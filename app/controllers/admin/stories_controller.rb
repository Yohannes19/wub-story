class Admin::StoriesController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
  
    def index
      @stories = Story.all
    end
  
    def approve
      story = Story.find(params[:id])
      story.update(status: "approved")
      redirect_to admin_stories_path, notice: "Story approved."
    end
  
    def reject
      story = Story.find(params[:id])
      story.update(status: "rejected")
      redirect_to admin_stories_path, notice: "Story rejected."
    end
  
    def destroy
      story = Story.find(params[:id])
      story.destroy
      redirect_to admin_stories_path, notice: "Story deleted."
    end
  
    private
  
    def require_admin!
      redirect_to root_path, alert: "Not authorized." unless current_user.admin?
    end
  end
  