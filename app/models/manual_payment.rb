# encoding: UTF-8
class ManualPayment < Payment
  attr_accessible :completed, :completed_at, :manual_company_email, :manual_company_name, :manual_contact_person, :manual_invoice_sent, :manual_post_code, :manual_street_address, :paid_amount, :price

  validates_presence_of :manual_company_name, :manual_contact_person
  validate :has_a_place_to_send_invoice


  private
  def has_a_place_to_send_invoice
    if manual_company_email.blank? and manual_street_address.blank?
      errors.add(:manual_company_email, "oppgi enten epost eller gateadresse")
    end

  end
end