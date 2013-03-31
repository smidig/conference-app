class PaymentsController < ApplicationController
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
  end

  def create_paypal
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

  def create_manual
  end

  # Complete an existing payment
  def complete
    payment = Payment.find(params[:id])
    if payment.type == 'PaypalPayment'
      complete_with_paypal(payment)
    else
      redirect_to :action => :create_manual_payment, :id => @create_manual_payment.id
    end
  end


  private

  def complete_with_paypal(payment)
    redirect_to payment.payment_url(payment_notifications_url, payments_paypal_completed_url)
  end

  def complete_with_invoice(order)
    #TODO:
    # verify order contains atleast 3 users
    # create invoice payment
    # send emails to admins
  end
end
