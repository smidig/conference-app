# == Schema Information
#
# Table name: talk_categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TalkCategory < ActiveRecord::Base
  attr_accessible :name

  has_many :talk
end
