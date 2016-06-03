# encoding: UTF-8
class TalksController < ApplicationController

  no_authorization! :only => [:new, :show, :list]

  authorize_admin! :only => [:index, :vote, :destroy, :status]

  authorize_user! :only => :create

  helper_method :get_talk_types, :get_voters

  authorize! :only => [:edit, :update] do
    talk = Talk.find(params[:id])

    unless current_user.admin? || talk.user == current_user
      permission_denied('Du er ikke taleren som opprettet denne talk', my_profile_index_path)
    end
  end

  before_filter :redirect_to_create_user_if_not_logged_in, :only => :new

  # GET /talks
  # GET /talks.json
  def index
    @talk_type_count = Talk.talk_type_count_cached

    @talks = Talk.all_cached

    respond_to do |format|
      format.html # index.html.haml
      format.json { render json: @talks }
      format.csv {
        @filename = "Smidig_foredrag_#{Date.today.to_formatted_s(:db)}.csv"
      }
    end
  end

  def list
    #@talks = Talk.order('id desc').all
    @talks = Talk.approved_cached

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
    if current_user.admin
      @talk_types = TalkType.all
    else
      @talk_types = TalkType.find(:all, :conditions => {:visible => true})
    end

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
      if @talk.update_attributes(params[:talk], :as => (admin? || @talk.user == current_user) ? :admin : :default)
        # Change to be set on e-mail request insted of directly from edit form
        if @new_user
          @talk.users << @new_user
          @talk.save
        end

        format.html { redirect_to :back, notice: "Talk was successfully updated." }
        format.json { head :no_content }
        format.js {
          render "update",
                 :locals => {
                     :id => params[:id],
                     :talk => @talk
                 }
        }
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
    @talk.vote :voter => current_user, :vote => !current_user.voted_as_when_voted_for(@talk)
    flash[:notice] = "Vote registered."

    respond_to do |format|
      format.html { redirect_to talks_url }
      format.json { head :no_content }
      format.js {
        render "update",
               :locals => {
                   :id => params[:id],
                   :talk => @talk
               }
      }
    end
  end

  # POST /talks/1/status
  def status
    @talk = Talk.find(params[:id])
    @status = params[:status]

    unless @status == @talk.status
      @talk.status = @status
      @talk.save

      if (@status == "approved_and_confirmed")
        SmidigMailer.talk_acceptance_confirmation(@talk).deliver

        # Confirm user as speaker if talk gets approved
        unless @talk.user.completed
          @talk.user.completed = true
          @talk.user.save
        end

      elsif (@status == "rejected")
        SmidigMailer.talk_refusation_confirmation(@talk).deliver
      end
    end

    respond_to do |format|
      format.html { redirect_to talks_url }
      format.json { head :no_content }
      format.js {
        render "update",
               :locals => {
                   :id => params[:id],
                   :talk => @talk
               }
      }
    end
  end

  private

  def get_talk_types
    if current_user.admin
      @talk_types = TalkType.all
    else
      @talk_types = TalkType.find(:all, :conditions => {:visible => true})
    end
    return @talk_types
  end

  def get_voters(talk)
    voters = "";
    total_length = talk.upvotes.length - 1
    talk.upvotes.each_with_index do |vote, index|
      if vote.voter
        voters = voters + " " + vote.voter.name
      else
        voters = voters + "?(#{vote.id})"
      end
      
      if index < total_length
        voters = voters + ","
      end

    end
    return voters
  end

  def redirect_to_create_user_if_not_logged_in
    if not current_user
      session[:return_to] = request.fullpath
      flash[:notice] = "Du må opprette en bruker før du kan registrere en lyntale eller workshop. " +
          "Etter utfylling av din brukerinformasjon vil du få anledning til å angi innhold i foredraget ditt. " +
          "Dersom du allerede har en bruker kan du logge inn via \"Min Profil\"."
      redirect_to new_user_registration_path(:ticket_name => "Speaker")
      return false
    end
  end

end
