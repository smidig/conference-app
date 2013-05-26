# encoding: UTF-8
class OrdersController < ApplicationController
  before_filter :require_admin, :only => [:index, :destroy]
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
    if(current_user.admin && params[:id])
      @order = Order.find(params[:id])
    else
      @order = Order.find_by_owner_user_id(current_user.id)
    end

    if(@order.nil?)
      @order = Order.create({:owner_user_id => current_user.id})
      @order.save
      current_user.order_id = @order.id
      current_user.save!
    end
    puts "Order: #{@order}"
  end

  def add_user
    #@order set by filter
    @user = User.create({
      :name => params[:user][:name],
      :email => params[:user][:email],
      :tlf => params[:user][:tlf],
      :ticket_id => params[:user][:ticket_id],
      :password => Devise.friendly_token.first(9),
      :company => @order.owner.company,
      :accepted_privacy => "1"
    })

    @user.order_id = @order.id

    if @user.save
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
      @order = Order.find_by_owner_user_id(current_user.id)
    end

    if @order.completed or @order.payment
      flash[:alert] = 'Kan ikke legge til brukere på din bestilling etter at en betaling er startet.'
      redirect_to :action => :show, :id => @order.id
    end
  end
end
