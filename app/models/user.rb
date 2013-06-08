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
  attr_accessible :name, :tlf, :company, :accepted_privacy, :twitter, :accepted_optional_email, :allergies, :ticket_id, :order, :includes_dinner

  # validations
  validates_presence_of :name, :tlf, :company
  validates_acceptance_of :accepted_privacy
  validate :require_active_ticket

  belongs_to :ticket
  belongs_to :order
  has_and_belongs_to_many :talks

  def require_active_ticket
    if ticket and !ticket.active
      errors.add(:ticket, :not_active)
    elsif ticket.nil?
      errors.add(:ticket, :blank)
    end
  end
end
