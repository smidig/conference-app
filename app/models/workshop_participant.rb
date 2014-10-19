# -*- encoding : utf-8 -*-
class WorkshopParticipant < ActiveRecord::Base
  attr_accessible :user, :talk
  belongs_to :user
  belongs_to :talk
  validates_uniqueness_of :talk_id, :scope => :user_id
  validate :no_users_before_registration_opens

  private

  def no_users_before_registration_opens
    unless talk.registrations_open_at.try(:past?)
      errors.add(:talk, 'no registrations until the opening date')
    end
  end
end
