class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def admin?
    current_user and current_user.admin
  end

  def require_admin
    if not current_user
      store_location
      flash[:notice] = "You must login as an admin to access this view."
      redirect_to new_user_session_url
      return false
    elsif current_user and  not current_user.admin
      flash[:alert] = "You must be an admin to access this view."
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

end
