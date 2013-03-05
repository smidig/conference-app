class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by_owner_user_id(current_user.id)
    if(@order.nil?)
      @order = Order.create({:owner_user_id => current_user.id})
      @order.save
      current_user.order_id = @order.id
      current_user.save!
    end
    puts "Order: #{@order}"
  end

  def complete
    @order = Order.find_by_owner_user_id(current_user.id)
    type = params[:type]

    if(type == "invoice")
      complete_with_invoice(@order)
    else
      complete_with_paypal(@order)
    end
  end

  def add_user
    @order = Order.find_by_owner_user_id(current_user.id)
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
    @order = Order.find_by_owner_user_id(current_user.id)
    @user = User.new
  end

  private

  def complete_with_paypal(order)
    if(order.payment.nil?)
      payment = PaypalPayment.new({
          :price => order.price,
          :order_id => order.id
        })
      payment.save!
    else
      payment = order.payment
    end
    order.completed = true
    order.save!
    redirect_to payment.payment_url(payment_notifications_url, home_index_url)
  end

  def complete_with_invoice(order)
    #TODO:
    # verify order contains atleast 3 users
    # create invoice payment
    # send emails to admins
  end
end
