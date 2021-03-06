# encoding: UTF-8
class ManualPayment < Payment
  attr_accessible :completed, :completed_at, :manual_company_email, :manual_company_name, :manual_contact_person, :manual_invoice_sent, :manual_post_code, :manual_street_address, :manual_invoice_id, :paid_amount, :price, :manual_city, :manual_organization_number

  validates_presence_of :manual_company_name, :manual_contact_person
  validate :has_a_place_to_send_invoice
  validates :manual_organization_number, length: {minimum: 9, maximum: 9}, allow_blank: true

  def status
    if completed?
      "Betalt"
    elsif manual_invoice_sent?
      "Faktura sent. Venter på betaling."
    else
      "Fakura opprettet. Ikke sendt."
    end
  end

  private

  def has_a_place_to_send_invoice
    if manual_company_email.blank? && manual_street_address.blank?
      errors.add(:manual_company_email, "oppgi enten epost eller gateadresse")
    end
  end
end
