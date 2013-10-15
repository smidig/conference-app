class AdministrationController < ApplicationController
  authorize_admin!
  layout "fullwidth"
end
