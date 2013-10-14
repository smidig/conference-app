class ProgramController < ApplicationController
  authorize_admin!
  before_filter lambda { @body_class = 'admin' }

  def index
    #@roomslots = Roomslot.all

    #@timeslot = Timeslot.find(:all, :group => :start)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talk_types }
    end
  end

end
