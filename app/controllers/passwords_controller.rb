class PasswordsController < Devise::PasswordsController
  no_authorization!
end
