class RoomslotsController < ApplicationController
  # GET /roomslots
  # GET /roomslots.json
  def index
    @roomslots = Roomslot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @roomslots }
    end
  end

  # GET /roomslots/1
  # GET /roomslots/1.json
  def show
    @roomslot = Roomslot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @roomslot }
    end
  end

  # GET /roomslots/new
  # GET /roomslots/new.json
  def new
    @roomslot = Roomslot.new
    if params[:timeslot_id]
      @roomslot.timeslot = Timeslot.find(params[:timeslot_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @roomslot }
    end
  end

  # GET /roomslots/1/edit
  def edit
    @roomslot = Roomslot.find(params[:id])
  end

  # POST /roomslots
  # POST /roomslots.json
  def create
    @roomslot = Roomslot.new(params[:roomslot])

    respond_to do |format|
      if @roomslot.save
        format.html { redirect_to timeslots_path, notice: 'Roomslot was successfully created.' }
        format.json { render json: @roomslot, status: :created, location: @roomslot }
      else
        format.html { render action: "new" }
        format.json { render json: @roomslot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /roomslots/1
  # PUT /roomslots/1.json
  def update
    @roomslot = Roomslot.find(params[:id])

    respond_to do |format|
      if @roomslot.update_attributes(params[:roomslot])
        format.html { redirect_to @roomslot, notice: 'Roomslot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @roomslot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roomslots/1
  # DELETE /roomslots/1.json
  def destroy
    @roomslot = Roomslot.find(params[:id])
    @roomslot.destroy

    respond_to do |format|
      format.html { redirect_to timeslots_url }
      format.json { head :no_content }
    end
  end
end
