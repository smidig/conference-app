class SessionsController < Devise::SessionsController
  no_authorization!
end
