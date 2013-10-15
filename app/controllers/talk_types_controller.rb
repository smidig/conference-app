class TalkTypesController < ApplicationController
  authorize_admin!
  layout "fullwidth"

  # GET /talk_types
  # GET /talk_types.json
  def index
    @talk_types = TalkType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @talk_types }
    end
  end

  # GET /talk_types/1
  # GET /talk_types/1.json
  def show
    @talk_type = TalkType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @talk_type }
    end
  end

  # GET /talk_types/new
  # GET /talk_types/new.json
  def new
    @talk_type = TalkType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @talk_type }
    end
  end

  # GET /talk_types/1/edit
  def edit
    @talk_type = TalkType.find(params[:id])
  end

  # POST /talk_types
  # POST /talk_types.json
  def create
    @talk_type = TalkType.new(params[:talk_type])

    respond_to do |format|
      if @talk_type.save
        format.html { redirect_to @talk_type, notice: 'Talk type was successfully created.' }
        format.json { render json: @talk_type, status: :created, location: @talk_type }
      else
        format.html { render action: "new" }
        format.json { render json: @talk_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talk_types/1
  # PUT /talk_types/1.json
  def update
    @talk_type = TalkType.find(params[:id])

    respond_to do |format|
      if @talk_type.update_attributes(params[:talk_type])
        format.html { redirect_to @talk_type, notice: 'Talk type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talk_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /talk_types/1
  # DELETE /talk_types/1.json
  def destroy
    @talk_type = TalkType.find(params[:id])
    @talk_type.destroy

    respond_to do |format|
      format.html { redirect_to talk_types_url }
      format.json { head :no_content }
    end
  end
end
