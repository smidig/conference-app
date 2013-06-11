class ApplicationController < ActionController::Base
  protect_from_forgery

  include Authorization

  # Every actions requires admin privileges by default. This behavior can be overridden
  # by using #no_authorization!, #authorize_user! or #authorize!. This ensures that we
  # whitelist access to controller actions, instead of blacklist.
  authorize_admin!

  private

  def admin?
    current_user.try(:admin)
  end

end
