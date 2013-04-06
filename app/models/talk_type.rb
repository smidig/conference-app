# == Schema Information
#
# Table name: talk_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  duration   :integer
#  visible    :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TalkType < ActiveRecord::Base
  attr_accessible :duration, :name, :visible

  has_many :talks
end
