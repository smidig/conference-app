class RegistrationsController < Devise::RegistrationsController
  def new
    set_up_default_tickets
    super
  end

  def create
    set_up_default_tickets
    super
  end

  def sign_up(resource_name, resource)
    # TODO: Add a special email for speakers..
    if (@user.ticket.ticket_type == "regular")
      SmidigMailer.registration_confirmation(@user).deliver
    elsif (@user.ticket.ticket_type == "speaker")

    else
      SmidigMailer.free_registration_confirmation(@user).deliver
      SmidigMailer.free_registration_notification(@user, users_url).deliver
    end
    sign_in(resource_name, resource)
  end

  def after_sign_up_path_for(user)
    # TODO: Send user to add talk if speaker
    if (user.ticket.ticket_type == "regular")
      orders_show_path
    elsif (user.ticket.ticket_type == "speaker")
      new_talk_path
    else
      root_path
    end
  end

  private

  def set_up_default_tickets
    @tickets = Ticket.visible
    @ticket_default = Ticket.default

    # Enable override of special tickets from param
    special_ticket = Ticket.find_by_name(params[:ticket_name])
    if special_ticket
      @tickets.push special_ticket
      @ticket_default = special_ticket
    end
  end


end