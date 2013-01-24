class TalkCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :talk
end
