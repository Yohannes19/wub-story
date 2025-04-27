class FavoritesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_story


    def create
        @favorite = @story.favorites.find_or_initialize_by(user: current_user)
        if @favorite.persisted? || @favorite.save
            redirect_to @story, notice: 'Story was successfully added to favorites.'
        else
            redirect_to @story, alert: 'Unable to add story to favorites.'
        end
    end

    def destroy
        @favorite = Favorite.find(params[:id])  # Favorite id from the URL
        @favorite.destroy
        redirect_to @favorite.story, notice: 'Story was successfully removed from favorites.'
    end

    private

    def set_story
    @story = Story.find(params[:story_id])
    end
end 