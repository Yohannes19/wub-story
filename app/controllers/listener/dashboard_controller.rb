# app/controllers/listener/dashboard_controller.rb
class Listener::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @recent_stories = Story.order(created_at: :desc).limit(10)

    @categories = Story.distinct.pluck(:category)
    @languages = Story.distinct.pluck(:language)

    @stories = Story.all
    @stories = @stories.where(category: params[:category]) if params[:category].present?
    @stories = @stories.where(language: params[:language]) if params[:language].present?
    @stories = @stories.order(created_at: :desc)

   
    if params[:query].present?
      @stories = @stories.where("title ILIKE :q OR description ILIKE :q", q: "%#{params[:query]}%")
    end

    if params[:category].present? && params[:category] != "All"
      @stories = @stories.where(category: params[:category])
    end

    if params[:language].present? && params[:language] != "All"
      @stories = @stories.where(language: params[:language])
    end

    @stories = @stories.order(created_at: :desc)
  end
end
