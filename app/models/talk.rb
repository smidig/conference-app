class Talk < ActiveRecord::Base
  attr_accessible :title, :description, :talk_type, :talk_type_id, :talk_category, :talk_category_id, :presentation, :as => [ :default, :admin ]
  attr_accessible :cospeakers, :as => :default
  attr_accessible :status, :user, :as => :admin

  STATUS_OPTIONS = %w(approved_and_confirmed approved rejected pending)

  belongs_to :talk_type
  belongs_to :talk_category
  belongs_to :user
  has_and_belongs_to_many :cospeakers

  has_attached_file :presentation
  validates_attachment_size :presentation, :less_than => 10.megabytes

  validates :status, :inclusion => {:in => STATUS_OPTIONS}, :allow_nil => true

  validates_presence_of :title, :description, :talk_type, :talk_category

end