class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def admin?
    current_user.try(:admin)
  end

  def require_admin
    if current_user and !current_user.admin
      flash[:alert] = "You must be an admin to access this view."
      redirect_to root_path
    elsif !current_user
      flash[:notice] = "You must login as an admin to access this view."
      redirect_to new_user_session_url
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

end
