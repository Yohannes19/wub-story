# app/controllers/narrator/dashboard_controller.rb
class Narrator::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_narrator

  def index
    @stories = current_user.stories.order(created_at: :desc)

    @views_over_time = Favorite.joins(:story)
    .where(stories: { user_id: current_user.id })
    .group("DATE(favorites.created_at)")
    .order("DATE(favorites.created_at)")
    .count
  
    @likes_over_time = Favorite.joins(:story)
    .where(stories: { user_id: current_user.id })
    .group("DATE(favorites.created_at)")
    .order("DATE(favorites.created_at)")
    .count
  
    @comments_over_time = Comment.joins(:story)
    .where(stories: { user_id: current_user.id })
    .group("DATE(comments.created_at)")
    .order("DATE(comments.created_at)")
    .count


  # Fake viewer locations for now (until you track real locations)
  @viewer_locations = {
    "Ethiopia" => 65,
    "United States" => 20,
    "Germany" => 10,
    "Others" => 5
  }
  end

  private

  def require_narrator
    redirect_to root_path, alert: 'Not authorized.' unless current_user.narrator?
  end
end
