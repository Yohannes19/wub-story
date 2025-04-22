# app/controllers/narrator/dashboard_controller.rb
class Narrator::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_narrator

  def index
    @stories = current_user.stories.order(created_at: :desc)
  end

  private

  def require_narrator
    redirect_to root_path, alert: 'Not authorized.' unless current_user.narrator?
  end
end
