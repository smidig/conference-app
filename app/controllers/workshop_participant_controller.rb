# -*- encoding : utf-8 -*-
class WorkshopParticipantController < ApplicationController
  authorize_user!

  def index
    @talk = Talk.find(params[:talk_id])
    
    if @talk.user_ids.include?(current_user.id) || current_user.admin
      @participants = @talk.workshop_participants.collect {|p| p.user }
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @participants }
      end
    else
      flash[:error] = "Access Denied"
      redirect_to new_user_path
    end
  end

  def create
    @talk = Talk.find(params[:talk_id])
    @wsp = WorkshopParticipant.new(:user => current_user, :talk => @talk)
    respond_to do |format|
      if @talk.ws_full?
        format.json  { render :json => "{status: 'full'}", :status => :unprocessable_entity}
        format.html { redirect_to(@talk, :notice => 'Workshoppen er full!') }
        format.js { 
          render "update",
          :locals => {
            :id => @talk.id, 
            :talk => @talk
          } 
        }
      elsif @wsp.save
        format.json  { render :json => "{status: 'ok'}", :status => :created}
        format.html { redirect_to(@talk, :notice => 'Du er med i workshoppen') }
        format.js { 
          render "update",
          :locals => {
            :id => @talk.id, 
            :talk => @talk
          } 
        }
      else
        format.json  { render :json => "{status: 'failed'}", :status => :unprocessable_entity}
        format.html { redirect_to(@talk, :notice => 'Du er ikke med i workshoppen') }
        format.js { 
          render "update",
          :locals => {
            :id => @talk.id, 
            :talk => @talk
          } 
        }
      end
    end
  end

  def destroy
    @wsp = WorkshopParticipant.find(params[:id])
    @talk = @wsp.talk

    if @wsp.user_id == current_user.id || current_user.is_admin?
      if @wsp.destroy
        flash[:notice] = "Du er ikke med lengre i workshoppen"
      end
      respond_to do |format|
        format.html { redirect_to(@talk) }
        format.js { 
          render "update",
          :locals => {
            :id => @talk.id, 
            :talk => @talk
          } 
        }
      end
    else
      flash[:error] = "Access Denied"
      redirect_to new_user_path
    end
  end
end
