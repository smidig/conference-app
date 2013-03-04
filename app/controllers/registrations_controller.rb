class RegistrationsController < Devise::RegistrationsController
  def new
  	puts "Overridden new method in devise"
    super
  end

  def create
  	puts "Overridden create method in devise"
  	super
  end

  def after_sign_up_path_for(user)
    if(user.ticket.price > 0)
      orders_show_path
    else
      edit_user_registration_path
    end
  end


end