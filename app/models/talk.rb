class Talk < ActiveRecord::Base
  attr_accessible :title, :description, :accepted_license, :talk_type, :talk_type_id, :talk_category, :talk_category_id, :users, :presentation, :as => [ :default, :admin ]
  attr_accessible :status, :user, :new_user, :user_ids, :as => :admin
  attr_accessor :new_user

  acts_as_votable

  STATUS_OPTIONS = %w(approved_and_confirmed approved rejected pending)

  belongs_to :talk_type
  belongs_to :talk_category
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :talk_comments

  has_attached_file :presentation
  validates_attachment_size :presentation, :less_than => 10.megabytes

  validates :status, :inclusion => {:in => STATUS_OPTIONS}, :allow_nil => true

  validates_presence_of :title, :description, :talk_type, :talk_category

  validates_acceptance_of :accepted_license

  after_save    :expire_talk_all_cache
  after_destroy :expire_talk_all_cache

  def self.all_cached
    Rails.cache.fetch('Talk.all') { order('id desc').all }
  end

  def expire_talk_all_cache
    Rails.cache.delete('Talk.all')
  end

end