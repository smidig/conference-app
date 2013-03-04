class Order < ActiveRecord::Base
  attr_accessible :comment, :completed, :owner_user_id
  has_many :users
  has_one :payment
  belongs_to :user, class_name: "User", foreign_key: "owner_user_id"

  def price
    totalSum = 0
    self.users.each do |u|
      unless u.ticket.nil?
        totalSum += u.ticket.price
      end
    end
    totalSum
  end

  def owner
    User.find(self.owner_user_id)
  end

end
