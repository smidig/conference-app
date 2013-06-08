# encoding: UTF-8
class TalksController < ApplicationController
  before_filter :authenticate_user! , :except => [:index, :show, :new]
  before_filter :redirect_to_create_user_if_not_logged_in, :only => [:new]
  before_filter :require_admin_or_talk_owner, :only => [:destroy, :edit]

  # GET /talks
  # GET /talks.json
  def index
    @talks = current_user.admin ? Talk.all : Talk.where(:user_id => current_user.id)

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
        format.html { redirect_to my_profile_index_path, notice: 'Takk, ditt foredragsforslag er registrert.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /talks/1
  # PUT /talks/1.json
  def update
    @talk = Talk.find(params[:id])
    @new_user = User.find_by_email(params[:talk][:new_user])


    respond_to do |format|
      if @talk.update_attributes(params[:talk], :as => (admin? or @talk.user == current_user)? :admin : :default)
        # Change to be set on e-mail request insted of directly from edit form
        if @new_user
          @talk.users << @new_user
          @talk.save
        end
        format.html { redirect_to :back, notice: "Talk was successfully updated." }
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
    if params[:id]
      talk = Talk.find(params[:id])
    end

    unless current_user.admin? or talk.user == current_user
      flash[:notice] = 'Du er ikke taleren som opprettet denne talk'
      redirect_to :back
    end
  end

  private

  def redirect_to_create_user_if_not_logged_in
    if not current_user
      store_location
      flash[:notice] = "Du må opprette en bruker før du kan registrere en lyntale eller workshop. " +
                       "Dersom du allerede har en bruker kan du logge inn via \"Min Profil\"."
      redirect_to new_user_registration_path(:ticket_name=>"Speaker")
      return false
    end
  end


end
