class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_story
  
    def create
      @comment = @story.comments.build(comment_params)
      @comment.user = current_user
      @comment.save
      redirect_to @story
    end
  
    def destroy
      @comment = @story.comments.find(params[:id])
      @comment.destroy if @comment.user == current_user
      redirect_to @story
    end

    def update
      @comment = @story.comments.find(params[:id])
      if @comment.user == current_user
        if @comment.update(comment_params)
          redirect_to @story, notice: 'Comment was successfully updated.'
        else
          render :edit
        end
      else
        redirect_to @story, alert: 'You are not authorized to update this comment.'
      end
    end

    def edit  
      @comment = @story.comments.find(params[:id])
      if @comment.user != current_user
        redirect_to @story, alert: 'You are not authorized to edit this comment.'
      end
    end




  
    private
  
    def set_story
      @story = Story.find(params[:story_id])
    end
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  