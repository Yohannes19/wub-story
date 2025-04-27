class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  add_flash_types :info, :warning, :success, :danger

    protected

    def after_sign_in_path_for(resource)
        dashboard_path
      end

    def after_sign_up_path_for(resource)
      new_user_session_path # Redirects to login page after sign up
    end

    def configure_permitted_parameters
      added_attrs = [:username, :bio, :location, :profile_image, :role]
      devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
      devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    end
end
