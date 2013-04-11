class PaymentsController < ApplicationController
  before_filter :require_admin, :only => [:index, :show, :destroy]
  before_filter :max_one_payment_per_order, :only => [:new_paypal, :new_manual, :create_manual]
  before_filter :require_admin_or_order_owner, :only => [:new_paypal, :new_manual, :create_manual]

  def index
    @payments = Payment.all
  end

  def show
    @payment = Payment.find(params[:id])
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  def paypal_completed
    # congrat user, open for all!
  end

  def manual_completed
    # congrat user, open for all!
  end

  def new_paypal
    order = Order.find(params[:order_id])
    order.transaction do
      payment = PaypalPayment.new({
          :price => order.price,
          :order_id => order.id
        })
      payment.save!
      complete_with_paypal(payment)
    end
  end

  def new_manual
    @manual_payment = ManualPayment.new
    @manual_payment.order_id = params[:order_id]
  end

  # Expects manual_order to have order_id set.
  def create_manual
    @manual_payment = ManualPayment.new(params[:manual_payment])
    @manual_payment.price = @manual_payment.order.price

    if @manual_payment.save
      redirect_to :action=> :manual_completed, :id=> @manual_payment.id
    else
      render action: "new_manual"
    end
  end

  # Complete an existing payment
  def complete
    payment = Payment.find(params[:id])
    if payment.type == 'PaypalPayment'
      complete_with_paypal(payment)
    else
      max_one payment.order
    end
  end


  private

  def max_one_payment_per_order
    if params[:order_id]
      order = Order.find(params[:order_id])
    elsif params[:manual_payment][:order_id]
      order = Order.find(params[:manual_payment][:order_id])
    end
    if order.payment and order.payment.type == 'PaypalPayment'
      complete_with_paypal(order.payment)
    elsif order.payment
      max_one order
    end
  end

  def require_admin_or_order_owner
    if params[:order_id]
      order = Order.find(params[:order_id])
    elsif params[:manual_payment][:order_id]
      order = Order.find(params[:manual_payment][:order_id])
    end

    unless current_user.admin or order.owner == current_user
      flash[:info] = 'Du er ikke eier av bestillingen'
      redirect_to info_index_url
    end
  end

  def complete_with_paypal(payment)
    redirect_to payment.payment_url(payment_notifications_url, payments_paypal_completed_url)
  end

  def max_one(order)
    flash[:info] = 'Kan maks registrere en betaling per bestilling.'
    redirect_to :controller => :orders, :action=> :show, :id => order.id
  end
end