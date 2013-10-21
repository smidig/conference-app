# -*- encoding : utf-8 -*-
class WorkshopParticipant < ActiveRecord::Base
  attr_accessible :user_id, :talk_id
  belongs_to :user
  belongs_to :talk
  validates_uniqueness_of :talk_id, :scope => :user_id
end