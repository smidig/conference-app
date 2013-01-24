class Talk < ActiveRecord::Base
  attr_accessible :title, :description, :talk_type, :talk_type_id, :talk_category, :talk_category_id

  belongs_to :talk_type
  belongs_to :talk_category

  validates_presence_of :title, :description, :talk_type, :talk_category
end