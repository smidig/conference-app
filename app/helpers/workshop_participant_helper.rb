# -*- encoding : utf-8 -*-
module WorkshopParticipantHelper
  def workshop_participation_link(talk, user)
    if talk.ws_participant?(user)
      wsp = talk.workshop_participants.where(:user_id => user.id).first
      button_to 'Meld deg av', workshop_participant_path(wsp),
              :confirm => "Sure?", :method => :delete, :class => 'btn btn-danger', :remote => true
    elsif talk.ws_full?
      """
      <span class='workshop-full'>Ingen plasser igjen</span>
      """.html_safe
    else
      button_to 'Meld deg på', workshop_participant_index_path(:talk_id => talk.id),
              :method => :post, :class => 'btn btn-success', :remote => true
    end
  end

  def conditional_link_to_participant_list(talk)
    n = talk.workshop_participants.count
    if (n == 0)
      "Ingen deltagere har registrert seg ennå."
    else
      link_to pluralize(n, 'deltaker', 'deltakere'),
            workshop_participant_index_path(:talk_id => talk.id)
    end
  end
end
