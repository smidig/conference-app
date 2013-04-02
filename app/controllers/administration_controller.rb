class AdministrationController < ApplicationController
	before_filter :require_admin
	
  def registrations
  end

  def send_mail
  end

  def statistics
  end
end
