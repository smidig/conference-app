class RegistrationsController < Devise::RegistrationsController
  no_authorization!

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
    if @user.ticket.ticket_type == "regular"
      SmidigMailer.registration_confirmation(@user).deliver
    elsif @user.ticket.ticket_type == "speaker"
      SmidigMailer.speaker_registration_confirmation(@user).deliver
      SmidigMailer.speaker_registration_notification(@user, users_url).deliver
    else
      SmidigMailer.free_registration_confirmation(@user).deliver
      SmidigMailer.free_registration_notification(@user, users_url).deliver
    end
    sign_in(resource_name, resource)
  end

  def after_sign_up_path_for(user)
    case user.ticket.ticket_type
      when 'speaker' then new_talk_path
      when 'regular' then orders_show_path
      when 'free'    then root_path
    end
  end

  def after_update_path_for(resource)
      my_profile_index_path
    end

  private

  def set_up_default_tickets
    @tickets = Ticket.visible
    @ticket_default = Ticket.default
    @all_tickets = Ticket.all

    # Enable override of special tickets from param
    if params[:ticket_name]
      @special_ticket = Ticket.find_by_name(params[:ticket_name])
      if @special_ticket.try(:active)
        @tickets.push @special_ticket
        @ticket_default = @special_ticket
      end
    end
  end


end
