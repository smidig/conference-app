class TalkType < ActiveRecord::Base
  attr_accessible :duration, :name, :visible

  has_many :talks
end
