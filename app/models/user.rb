# encoding: UTF-8
class User < ActiveRecord::Base
  acts_as_voter
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  default_scope order('created_at DESC')
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :accepted_privacy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tlf, :company, :role, :accepted_privacy, :twitter, :accepted_optional_email, :allergies, :ticket_id, :order, :includes_dinner

  # validations
  validates_presence_of :name, :tlf, :company
  validates_acceptance_of :accepted_privacy
  validate :require_active_ticket

  belongs_to :ticket
  belongs_to :order
  has_one :owned_order, :class_name => 'Order', :foreign_key => 'owner_user_id'
  has_and_belongs_to_many :talks

  after_save :correct_order, :if => :ticket_id_changed?

  def roles
    [
      "Utvikler",
      "Arkitekt",
      "Tester",
      "Drifter",
      "Designer",
      "UX spesialist",
      "Prosjektleder",
      "Linjeleder",
      "Direktør",
      "Annet"
    ]
  end

  private

  def require_active_ticket
    if ticket and !ticket.active
      errors.add(:ticket, :not_active)
    elsif ticket.nil?
      errors.add(:ticket, :blank)
    end
  end

  def correct_order
    if needs_order?
      create_default_order
    else
      destroy_order
    end
  end

  def needs_order?
    ticket.ticket_type == 'regular'
  end

  def create_default_order
    unless order
      transaction do
        create_order!(:owner => self)
        save!
      end
    end
  end

  def destroy_order
    order.destroy if order
  end
end
