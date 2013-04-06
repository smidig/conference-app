# == Schema Information
#
# Table name: talks
#
#  id                        :integer          not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  title                     :string(255)
#  description               :text
#  talk_type_id              :integer
#  talk_category_id          :integer
#  presentation_file_name    :string(255)
#  presentation_content_type :string(255)
#  presentation_file_size    :integer
#  presentation_updated_at   :datetime
#

class Talk < ActiveRecord::Base
  attr_accessible :title, :description, :talk_type, :talk_type_id, :talk_category, :talk_category_id, :presentation

  belongs_to :talk_type
  belongs_to :talk_category

  has_attached_file :presentation

  validates_attachment_size :presentation, :less_than => 10.megabytes

  validates_presence_of :title, :description, :talk_type, :talk_category
end
