# encoding: UTF-8
class OrdersController < ApplicationController
  authorize_user! :only => [:show, :add_user, :new_user]
  authorize_admin! :only => [:index, :destroy]

  layout "fullwidth", :only => :index

  before_filter :redirect_if_order_completed, :only => [:add_user, :new_user]

  def index
    @orders = Order.all
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy

    respond_to do |format|
      format.html { redirect_to(orders_url) }
      format.xml  { head :ok }
    end
  end

  def show
    if current_user.admin && params[:id]
      @order = Order.find(params[:id])
    else
      @order = current_user.owned_order
    end
  end

  def add_user
    #@order set by filter
    @user = User.new(params[:user].merge({
      :order => @order,
      :password => Devise.friendly_token.first(9),
      :company => @order.owner.company,
      :accepted_privacy => "1"
    }))

    if @user.save
      SmidigMailer.user_added_to_order_confirmation(@user, @order.owner, new_user_password_url).deliver
      redirect_to :action => "show", :id => @order.id
    else
      render action: "new_user"
    end
  end

  def new_user
    #@order set by filter
    @user = User.new
  end

  private

  def redirect_if_order_completed
    if current_user.admin && params[:id]
      @order = Order.find(params[:id])
    elsif current_user.admin && params[:order_id]
      @order = Order.find(params[:order_id])
    else
      @order = current_user.owned_order
    end

    if @order.completed || @order.payment
      flash[:alert] = 'Kan ikke legge til brukere på din bestilling etter at en betaling er startet.'
      redirect_to :action => :show, :id => @order.id
    end
  end
end
