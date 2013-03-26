class RegistrationsController < Devise::RegistrationsController
  def new
    @tickets = Ticket.visible
    @ticket_default = Ticket.default

    # Enable override of special tickets from param
    special_ticket = Ticket.find_by_name(params[:ticket_name])
    if special_ticket
      @tickets.push special_ticket
      @ticket_default = special_ticket
    end

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
      # TODO: send user to my-profile if sponsor or organizer
      # TODO: Send user to add talk if speaker
      edit_user_registration_path
    end
  end


end