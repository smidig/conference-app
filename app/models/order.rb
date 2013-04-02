# encoding: UTF-8
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

  def status
    if self.payment
      self.payment.status
    else
      "Ingen betaling startet"
    end
  end

  def payment_created
    return self.payment != nil
  end

  def owner
    User.find(self.owner_user_id)
  end

  def finish
    self.transaction do
      self.users.each do |user|
        user.completed=true
        user.save!
      end
      self.completed=true
      self.save!
    end
  end

end
