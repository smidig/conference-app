class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :accepted_privacy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tlf, :company, :accepted_privacy, :twitter, :accepted_optional_email, :allergies, :ticket_id, :order, :includes_dinner

  # validations
  validates_presence_of :name, :tlf
  validates_acceptance_of :accepted_privacy

  belongs_to :ticket
  belongs_to :order
  belongs_to :talk

end
