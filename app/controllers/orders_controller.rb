class OrdersController < ApplicationController
  before_filter :redirect_if_order_completed, :only => [:complete, :add_user, :new_user]

  def index
    @orders = Order.all
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
      :accepcted_privacy => true
    })

    @user.order_id = @order.id

    if @user.save
      redirect_to :action => "show"
    else
      render action: "new_user"
    end
  end

  def new_user
    #@order set by filter
    @user = User.new
  end

  def complete
    #@order set by filter
    @order.transaction do
      @order.completed = true
      @order.save!
    end

    if(params[:type] == "invoice")
      redirect_to :controller=>'payments', :action => 'create_manual', :order_id => @order.id
    else
      redirect_to :controller=>'payments', :action => 'create_paypal', :order_id => @order.id
    end
  end


  private

  def redirect_if_order_completed
    if current_user.admin && params[:id]
      @order = Order.find(params[:id])
    else
      @order = Order.find_by_owner_user_id(current_user.id)
    end

    if @order.completed
      flash[:warning] = 'Cannot perform actions on a completed order!'
      redirect_to :action => :show, :id => @order.id
    end
  end
end