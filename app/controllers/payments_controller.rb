class PaymentsController < ApplicationController
  before_filter :require_admin, :only => [:index, :show, :destroy, :manual, :invoice_sent, :finish]
  before_filter :max_one_payment_per_order, :only => [:new_paypal, :new_manual, :create_manual]
  before_filter :require_admin_or_order_owner, :only => [:new_paypal, :new_manual, :create_manual]
  before_filter lambda { @body_class = 'admin' }, :only => [:index, :manual]

  def index
    @payments = Payment.all
  end

  def manual
    @incomplete = ManualPayment.all(:conditions => {:manual_invoice_sent => [nil, false]})
    @invoiced = ManualPayment.all(:conditions => {:manual_invoice_sent => true, :completed => [nil, false]})
    @completed = ManualPayment.all(:conditions => {:completed => true})

    respond_to do |format|
      format.html #manual.html.haml
      format.csv  {
        #manual.csv.shaper
        @filename = "Smidig_faktura_#{Date.today.to_formatted_s(:db)}.csv"
      }
    end
  end

  def show
    @payment = Payment.find(params[:id])
    if @payment.type == 'PaypalPayment'
      render "show_paypal"
    else
      render "show_manual"
    end
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy

    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  def invoice_sent
    payment = Payment.find(params[:id])
    invoice_id = params[:manual_payment][:manual_invoice_id]

    if invoice_id.blank?
      flash[:alert] = "Du mangler fakturaid for faktura #{payment.id}"
    else
      payment.manual_invoice_sent = true
      payment.manual_invoice_id = invoice_id
      payment.save
    end

    respond_to do |format|
      format.html { redirect_to payments_manual_url }
      format.json { head :no_content }
    end
  end

  def finish
    @payment = Payment.find(params[:id])
    @payment.paid_amount = @payment.price
    @payment.save!
    @payment.finish

    respond_to do |format|
      format.html { redirect_to payments_manual_url }
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
      redirect_to get_paypal_url(payment)
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
      SmidigMailer.manual_payment_created_confirmation(@manual_payment).deliver
      SmidigMailer.manual_payment_created_notification(@manual_payment, payments_manual_url).deliver
      redirect_to :action=> :manual_completed, :id=> @manual_payment.id
    else
      render action: "new_manual"
    end
  end

  # Complete an existing payment
  def complete
    payment = Payment.find(params[:id])
    if payment.type == 'PaypalPayment'
      redirect_to get_paypal_url(payment)
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
    if order.payment && order.payment.type == 'PaypalPayment'
      redirect_to get_paypal_url(order.payment)
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
      flash[:notice] = 'Du er ikke eier av bestillingen'
      redirect_to info_index_url
    end
  end

  def get_paypal_url(payment)
    payment.payment_url(payment_notifications_url, payments_paypal_completed_url)
  end

  def max_one(order)
    flash[:notice] = 'Kan maks registrere en betaling per bestilling.'
    redirect_to :controller => :orders, :action=> :show, :id => order.id
  end
end
