# app/controllers/listener/dashboard_controller.rb
class Listener::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = Story.distinct.pluck(:category)
    @languages = Story.distinct.pluck(:language)

    @stories = Story.all

    if params[:query].present?
      @stories = @stories.where("title ILIKE :q OR description ILIKE :q", q: "%#{params[:query]}%")
    end

    if params[:category].present? && params[:category] != "All"
      @stories = @stories.where(category: params[:category])
    end

    if params[:language].present? && params[:language] != "All"
      @stories = @stories.where(language: params[:language])
    end

    @stories = @stories.order(created_at: :desc).limit(50) 
  end
end
