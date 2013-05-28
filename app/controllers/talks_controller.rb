class TalksController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :show]
  before_filter :require_admin_or_talk_owner, :only => [:destroy]

  # GET /talks
  # GET /talks.json
  def index
    @talks = Talk.all

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @talks }
    end
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
    @talk = Talk.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @talk }
    end
  end

  # GET /talks/new
  # GET /talks/new.json
  def new
    @talk = Talk.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @talk }
    end
  end

  # GET /talks/1/edit
  def edit
    @talk = Talk.find(params[:id])
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(params[:talk], :as => admin? ? :admin : :default)
    @talk.user = current_user

    respond_to do |format|
      if @talk.save()
        format.html { redirect_to @talk, notice: 'Talk was successfully created.' }
        format.json { render json: @talk, status: :created, location: @talk }
      else
        format.html { render action: "new" }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /talks/1
  # PUT /talks/1.json
  def update
    @talk = Talk.find(params[:id])

    respond_to do |format|
      #if @talk.update_attributes(params[:talk], :as => :admin)
      if @talk.update_attributes(params[:talk], :as => admin? ? :admin : :default)
        format.html { redirect_to @talk, notice: "Talk was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @talk.errors, status: :unprocessable_entity, notice: 'Failed' }
      end
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy
    flash[:notice] = "Talk has been deleted."

    respond_to do |format|
      format.html { redirect_to talks_url }
      format.json { head :no_content }
    end
  end

  # POST /talks/1/vote
  def vote
    @talk = Talk.find(params[:id])
    @talk.vote :voter => current_user, :vote => !(current_user.voted_as_when_voted_for @talk) ? true : false
    flash[:notice] = "Vote registered."

    respond_to do |format|
      format.html { redirect_to talks_url }
      format.json { head :no_content }
    end
  end

  def require_admin_or_talk_owner
    if params[:talk_id]
      talk = Talk.find(params[:talk_id])
    end

    unless current_user.admin? or talk.users == current_user
      flash[:notice] = 'Du er ikke taleren som opprettet denne talk'
      redirect_to talks_path
    end
  end
  
end
