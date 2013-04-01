class PaymentsController < ApplicationController
  before_filter :require_admin, :only => [:index, :show, :destroy]
  before_filter :require_admin_or_order_owner, :only => [:new_paypal]

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
    # congrat user!
  end

  def manual_completed
    # congrat user!
  end

  def new_paypal
    order = Order.find(params[:order_id])

    if order.payment.nil?
      order.transaction do
        payment = PaypalPayment.new({
            :price => order.price,
            :order_id => order.id
          })
        payment.save!
        complete_with_paypal(payment)
      end
    elsif order.payment.type == 'PaypalPayment'
      complete_with_paypal(order.payment)
    else
      complete_with_invoice(order.payment)
    end
  end

  def new_manual
    order = Order.find(params[:order_id])
    if order.payment.nil?
      @manual_payment = ManualPayment.new
      @manual_payment.order_id = params[:order_id]
    else
      manual_exists(order)
    end
  end

  def create_manual
    @manual_payment = ManualPayment.new(params[:manual_payment])
    order = Order.find(@manual_payment.order_id)

    if !order.payment.nil?
      manual_exists(@order)
    else
      if @manual_payment.save
        redirect_to :action=> :manual_completed, :id=> @manual_payment.id
      else
        render action: "new_manual"
      end
    end
  end

  # Complete an existing payment
  def complete
    payment = Payment.find(params[:id])
    if payment.type == 'PaypalPayment'
      complete_with_paypal(payment)
    else
      manual_exists(payment.order)
    end
  end


  private

  def require_admin_or_order_owner
    order = Order.find(params[:order_id])
    unless current_user.admin or order.owner == current_user
      flash[:info] = 'Du er ikke eier av bestillingen'
      redirect_to home_index_url
    end
  end

  def complete_with_paypal(payment)
    redirect_to payment.payment_url(payment_notifications_url, payments_paypal_completed_url)
  end

  def manual_exists(order)
    flash[:info] = 'Kan maks registrere en betaling per bestilling'
    redirect_to :controller => :orders, :action=> :show, :id => order.id
  end
end
