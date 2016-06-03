module TalksHelper
  def suggesting_talk?
    params[:ticket_name] == 'Speaker'
  end

  def talk_suggestion_deadline
    Date.parse setting_for('talk-deadline-passed', '2000-01-01 00:00:00')
  end
end
