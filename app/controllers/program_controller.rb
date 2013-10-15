class ProgramController < ApplicationController
  authorize_admin!
  layout "fullwidth"

  def index
    @program = get_program_hash

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talk_types }
    end
  end

  def get_program_hash
    program = {:max_roomslots => 0, :start_wrappers => []}

    prev_start = Date.new(1970,01,01)
    start_wrapper = nil
    room_count = 0
    Timeslot.all.each do |t|
      puts t.roomslot.count

      if t.start > prev_start
        prev_start = t.start
        start_wrapper[:room_count] = room_count if start_wrapper
        start_wrapper = {:timeslots => [], :start => t.start, :room_count => 0}
        program[:start_wrappers].push(start_wrapper)

        if program[:max_roomslots] < room_count
          program[:max_roomslots] = room_count
        end
        room_count = 0
      end
      
      start_wrapper[:timeslots].push(t)
      room_count += t.roomslot.size
    end

    start_wrapper[:room_count] = room_count
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
