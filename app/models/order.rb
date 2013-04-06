# encoding: UTF-8
# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  comment       :string(255)
#  completed     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  owner_user_id :integer
#

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
