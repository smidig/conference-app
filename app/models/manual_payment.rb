# encoding: UTF-8
# == Schema Information
#
# Table name: payments
#
#  id                    :integer          not null, primary key
#  price                 :integer
#  paid_amount           :integer
#  completed             :boolean
#  completed_at          :datetime
#  paypal_params         :text
#  paypal_tx_id          :string(255)
#  paypal_tx_type        :string(255)
#  paypal_currency       :string(255)
#  paypal_status         :string(255)
#  paypal_payer_email    :string(255)
#  manual_company_name   :string(255)
#  manual_company_email  :string(255)
#  manual_contact_person :string(255)
#  manual_street_address :string(255)
#  manual_post_code      :string(255)
#  manual_invoice_sent   :boolean
#  order_id              :integer
#  type                  :string(255)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  invoice_id            :string(255)
#

class ManualPayment < Payment
  attr_accessible :completed, :completed_at, :manual_company_email, :manual_company_name, :manual_contact_person, :manual_invoice_sent, :manual_post_code, :manual_street_address, :paid_amount, :price

  validates_presence_of :manual_company_name, :manual_contact_person
  validate :has_a_place_to_send_invoice

  def status
    if self.completed?
      "Betalt"
    elsif self.manual_invoice_sent?
      "Faktura sent. Venter på betaling."
    else
      "Fakura opprettet. Ikke sendt."
    end
  end

  private
  def has_a_place_to_send_invoice
    if manual_company_email.blank? and manual_street_address.blank?
      errors.add(:manual_company_email, "oppgi enten epost eller gateadresse")
    end

  end
end
