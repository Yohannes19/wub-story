class FavoritesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_story

    def create
        @favourite = @story.favorites.create(user: current_user)
        if @favourite.save
            redirect_to @story, notice: 'Story was successfully added to favorites.'
        else
            redirect_to @story, alert: 'Unable to add story to favorites.'
        end
    end

    def destroy
        @favourite = @story.favorites.find(user: current_user)
        @favourite.destroy_all
        redirect_to @story, notice: 'Story was successfully removed from favorites.'
    end


    private


    def set_story
        @story = Story.find(params[:story_id])
    end

end
