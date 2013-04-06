# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  admin                   :boolean
#  name                    :string(255)
#  tlf                     :string(255)
#  company                 :string(255)
#  accepcted_privacy       :boolean
#  accepted_optional_email :boolean
#  twitter                 :string(255)
#  allergies               :string(255)
#  ticket_id               :integer
#  order_id                :integer
#  completed               :boolean
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :accepted_privacy

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tlf, :company, :accepted_privacy, :twitter, :accepted_optional_email, :allergies, :ticket_id, :order

  # validations
  validates_presence_of :name, :tlf
  validates_acceptance_of :accepted_privacy

  belongs_to :ticket
  belongs_to :order

end
