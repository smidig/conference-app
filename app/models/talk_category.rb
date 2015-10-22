class TalkCategory < ActiveRecord::Base
  attr_accessible :name, :abbreviation, :colour

  validates_presence_of :name, :abbreviation, :colour

  has_many :talk
end
