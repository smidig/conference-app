class AdministrationController < ApplicationController
  authorize_admin!
end
