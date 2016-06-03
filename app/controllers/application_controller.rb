class ApplicationController < ActionController::Base
  protect_from_forgery
  layout "fullwidth"

  include Authorization

  # Every action in deemed inaccessible to by default. This behavior can be overriden
  # by using #no_authorization!, #authorize_user! or #authorize!. This ensures that we
  # whitelist access to controller actions, instead of blacklist.
  deny_everything!

  private

  def admin?
    current_user.try(:admin)
  end

  def after_sign_in_path_for(resource_or_scope)
    if admin?
      users_path
    else
      my_profile_index_path
    end
  end

end
