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

  def show

  end


  def create

  end

  def destroy

  end

end
