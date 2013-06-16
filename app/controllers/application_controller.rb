class ApplicationController < ActionController::Base
  protect_from_forgery

  include Authorization

  # Every action in deemed inaccessible to by default. This behavior can be overriden
  # by using #no_authorization!, #authorize_user! or #authorize!. This ensures that we
  # whitelist access to controller actions, instead of blacklist.
  deny_everything!

  private

  def admin?
    current_user.try(:admin)
  end

end
