class RegistrationsController < Devise::RegistrationsController
  def new
  	puts "Overridden new method in devise"
    super
  end

  def create
  	puts "Overridden create method in devise"
  	super
    # add custom create logic here
  end
end 