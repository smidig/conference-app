class ProgramController < ApplicationController
  no_authorization!
  layout "fullwidth"

  def index
    @program = get_program_hash

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @program }
    end
  end

  # Should be rewritten to become a view model
  def get_program_hash
    program = {:max_roomslots => 0, :days => []}

    prev_start = Date.new(1970,01,01)
    start = nil
    day = nil
    room_count = 0
    Timeslot.all.each do |t|

      if(t.start.to_date > prev_start.to_date)
        day = {:starts => [], :date => t.start.to_date}
        program[:days].push(day)
      end

      if t.start > prev_start
        prev_start = t.start
        
        start[:room_count] = room_count if start
        start = {:timeslots => [], :start => t.start, :room_count => 0}
        
        day[:starts].push(start)
        
        if program[:max_roomslots] < room_count
          program[:max_roomslots] = room_count
        end
        room_count = 0
      end

      start[:timeslots].push(t)
      room_count += t.roomslot.size
    end

    start[:room_count] = room_count
    if program[:max_roomslots] < room_count
      program[:max_roomslots] = room_count
    end

    program
  end

  def program
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: get_program_hash }
    end
  end

end
