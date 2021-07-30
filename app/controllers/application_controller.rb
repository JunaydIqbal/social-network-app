class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to posts_path, :alert => exception.message
  end
  
  private
    def require_login
      unless current_user
        redirect_to root_path, flash: {error: "Access denied!"}
      end
    end
end

