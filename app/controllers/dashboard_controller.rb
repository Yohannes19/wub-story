# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.narrator?
      redirect_to narrator_dashboard_path
    elsif current_user.admin?
      redirect_to admin_dashboard_path
    else 
      redirect_to listener_dashboard_path
    end
  end
end
