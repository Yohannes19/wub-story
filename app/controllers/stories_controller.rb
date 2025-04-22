class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[ show edit update destroy ]
  before_action :require_narrator, only: %i[ new create]

  # GET /stories or /stories.json
  def index
    @stories = Story.all
  end

  # GET /stories/1 or /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories or /stories.json
  def create
    @story = Story.new(story_params)
    @story.user = current_user

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: "Story was successfully created." }
        format.json { render :show, status: :created, location: @story }
      else
        puts @story.errors.full_messages 
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: "Story was successfully updated." }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @story.destroy!

    respond_to do |format|
      format.html { redirect_to stories_path, status: :see_other, notice: "Story was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def transcribe
    # Placeholder logic - you can use Whisper or Deepgram here later
    @story.update(transcription: "This is a placeholder transcription.")
    redirect_to @story, notice: "Transcription complete."
  end
  
  def summarize
    # Placeholder logic - connect to OpenAI or your preferred summarizer
    @story.update(summary: "This is a summarized version of the story.")
    redirect_to @story, notice: "Summary generated successfully."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

 
    

    def require_narrator
      redirect_to root_path, alert: 'You are not authorized to upload stories.' unless current_user.narrator?
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.require(:story).permit(:title, :description, :language, :category, :audio, :cover_image, :user_id)
    end
end
