module TalksHelper
  def suggesting_talk?
    params[:ticket_name] == "Speaker"
  end

  def talk_suggestion_deadline
    Date.parse "2014-10-07"
  end
end
