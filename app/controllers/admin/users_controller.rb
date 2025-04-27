class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :require_admin!
  
    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end
    
  
    def suspend
        user = User.find(params[:id])
        user.update(suspended: true)
        redirect_to admin_users_path, notice: "User suspended."
    end
  
    def unsuspend
        user = User.find(params[:id])
        user.update(suspended: false)
        redirect_to admin_users_path, notice: "User unsuspended."
    end
  
    def destroy
        user = User.find(params[:id])
        user.destroy
        redirect_to admin_users_path, notice: "User deleted."
    end
  
    private
  
    def require_admin!
        redirect_to root_path, alert: "Not authorized." unless current_user.admin?
    end
  end
  