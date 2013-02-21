class Talk < ActiveRecord::Base
  attr_accessible :title, :description, :talk_type, :talk_type_id, :talk_category, :talk_category_id, :presentation

  belongs_to :talk_type
  belongs_to :talk_category

  has_attached_file :presentation

  validates_attachment_size :presentation, :less_than => 10.megabytes

  validates_presence_of :title, :description, :talk_type, :talk_category
end