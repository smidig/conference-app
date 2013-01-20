class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def admin?
    current_user and current_user.admin
  end

  def require_admin
    unless admin?
      store_location
      flash[:notice] = "You must be admin to access this view."
      redirect_to new_user_session_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

end
