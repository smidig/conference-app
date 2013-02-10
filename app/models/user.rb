class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tlf, :company, :accepcted_privacy, :twitter, :accepted_optional_email, :allergies, :ticket_id

  # validations
  validates_presence_of :name, :tlf
  validates_inclusion_of :accepcted_privacy, :in => [true]

  belongs_to :ticket

  #TODO: year should be config-param
  def invoice_id
    return "2013#{id}" if Rails.env == "production"
    return "2013t#{id}"
  end

  def payment_url(payment_notifications_url, return_url)
    values = {
      :business => PAYMENT_CONFIG[:paypal_email],
      :cmd => '_cart',
      :upload => '1',
      :currency_code => 'NOK',
      :notify_url => payment_notifications_url,
      :return => return_url,
      :invoice => invoice_id,
      #:amount_1 => ticket.price,
      :amount_1 => 1,
      :item_name_1 => ticket.name,
      :item_number_1 => '1',
      :quantity_1 => '1'
    }
    PAYMENT_CONFIG[:paypal_url] + "?"+values.map do
          |k,v| "#{k}=#{CGI::escape(v.to_s)}"
    end.join("&")
  end

end
