class FollowsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user!

    def create
        if current_user.follow(@user)
            redirect_back fallback_location: root_path, notice: "You are now following #{@user.email}."
        else
            redirect_back fallback_location: root_path, alert: "Cannot follow user."
        end
    end

    def destroy
        current_user.unfollow(@user)
        redirect_back fallback_location: root_path, notice: "You unfollowed #{@user.email}."
    end    

    private

    def set_user!
        @user = User.find(params[:user_id])
    end
end
