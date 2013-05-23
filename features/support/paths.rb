module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
      when /^the home\s?page$/
        '/'
      when /^the registration page$/
        new_user_registration_path
      when /^the login page$/
        new_user_session_path
      when /^the logout page$/
        destroy_user_session_path
      when /^the order page$/
        orders_show_path
      when /^the paypal completed page$/
        payments_paypal_completed_path
      when /^the users admin page$/
        users_path
      when /^the my profile page$/
        my_profile_index_path
      when /^the edit user registration page$/
        edit_user_registration_path
      else
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                  "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
