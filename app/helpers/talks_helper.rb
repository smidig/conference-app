module TalksHelper
  def suggesting_talk?
    params[:ticket_name] == 'Speaker'
  end

  def talk_suggestion_deadline
    Date.parse setting_for('talk-deadline-passed')
  end
end
