class AdministrationController < ApplicationController
	before_filter :require_admin
end
