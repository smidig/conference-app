module TalksHelper
  def suggesting_talk?
    params[:ticket_name] == "Speaker"
  end
end
