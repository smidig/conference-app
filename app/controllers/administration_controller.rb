class AdministrationController < ApplicationController
  authorize_admin!
  before_filter lambda { @body_class = 'admin' }
end
