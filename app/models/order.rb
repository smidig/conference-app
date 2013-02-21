class Order < ActiveRecord::Base
  attr_accessible :comment, :completed, :owner_user_id
  has_many :users
  belongs_to :user, class_name: "User", foreign_key: "owner_user_id"
end
