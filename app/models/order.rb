# encoding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :comment, :completed, :owner_user_id
  has_many :users
  has_one :payment
  belongs_to :user, class_name: "User", foreign_key: "owner_user_id"
  default_scope order('created_at DESC')

  def price
    users.map { |u| u.ticket and u.ticket.price }.compact.sum
  end

  def status
    if payment
      payment.status
    else
      "Ingen betaling startet"
    end
  end

  def payment_created
    !payment.nil?
  end

  def owner
    User.find(self.owner_user_id) rescue nil
  end

  def finish
    transaction do
      users.each do |user|
        user.completed = true
        user.save!
        SmidigMailer.payment_confirmation(user).deliver
      end
      self.completed = true
      save!
    end
  end

end
