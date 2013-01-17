class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :tlf, :company, :accepcted_privacy, :twitter, :accepted_optional_email

  # validations
  validates_presence_of :name, :tlf
  validates_inclusion_of :accepcted_privacy, :in => [true]

end