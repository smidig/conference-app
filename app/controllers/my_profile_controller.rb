class MyProfileController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user = current_user
    @order = current_user.order
  end

  def receipt
    @user = current_user
    @order = current_user.order

    if @user.completed?
      render :layout => false
    else
      flash[:error] = "Kan ikke vise kvittering - Du har ikke betalt"
      redirect_to :action => "index"
    end
  end

  def dinner_registration
    current_user.includes_dinner = params[:dinner] == "yes" ? true : false
    current_user.save!
    respond_to do |format|
      format.html { redirect_to :action => "index" }
      format.json  { head :ok }
    end
  end
end
