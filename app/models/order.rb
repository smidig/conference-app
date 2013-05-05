# encoding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :comment, :completed, :owner_user_id
  has_many :users
  has_one :payment
  belongs_to :user, class_name: "User", foreign_key: "owner_user_id"

  def price
    users.map { |u| u.ticket and u.ticket.price }.compact.sum
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
    User.find(self.owner_user_id) rescue nil
  end

  def finish
    self.transaction do
      self.users.each do |user|
        user.completed=true
        user.save!
        SmidigMailer.payment_confirmation(user).deliver
      end
      self.completed=true
      self.save!
    end
  end

end
