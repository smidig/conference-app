class Talk < ActiveRecord::Base
  attr_accessible :title, :description, :accepted_license, :talk_type, :talk_type_id, :talk_category, :talk_category_id, :users, :presentation, :as => [ :default, :admin ]
  attr_accessible :status, :user, :new_user, :user_ids, :registrations_open_at, :as => :admin
  attr_accessor :new_user

  acts_as_votable

  STATUS_OPTIONS = %w(approved_and_confirmed approved rejected pending)

  DEFAULT_MAX_WS_PARTICIPANTS = 20

  belongs_to :talk_type
  belongs_to :talk_category
  belongs_to :user
  has_and_belongs_to_many :users

  has_many :talk_comments
  
  belongs_to :roomslot

  has_many :workshop_participants
  has_many :feedback_votes

  has_attached_file :presentation, PAPERCLIP_CONFIG
  validates_attachment_size :presentation, :less_than => 50.megabytes

  validates :status, :inclusion => {:in => STATUS_OPTIONS}, :allow_nil => true

  validates_presence_of :title, :description, :talk_type, :talk_category

  validates_acceptance_of :accepted_license

  after_save    :expire_talk_all_cache
  after_destroy :expire_talk_all_cache

  def self.all_cached
    Rails.cache.fetch('Talk.all') { order('id desc').all }
  end

  def self.approved_cached
    Rails.cache.fetch('Talk.approved') { where(:status => 'approved_and_confirmed').all }
  end

  def self.talk_type_count_cached
    Rails.cache.fetch('Talk.talk_type_count') { talk_type_count }
  end

  def self.talk_type_count
    talk_count = []
    talk_type_id_approved_count = where("status = 'approved_and_confirmed' or status = 'approved'").count(:group => :talk_type_id)

    count(:group => :talk_type).each do |talk_type, count|
      o =  {
        :name => talk_type.name,
        :total => count,
        :approved => talk_type_id_approved_count[talk_type.id] || 0
      }
      talk_count.push(o)
    end

    talk_count
  end

  def expire_talk_all_cache
    Rails.cache.delete('Talk.all')
    Rails.cache.delete('Talk.approved')
    Rails.cache.delete('Talk.talk_type_count')
  end

  def ws_participant?(user)
    workshop_participants.map{|wp| wp.user_id}.include?(user.id)
  end

  def ws_full?
    workshop_participant_ids.count >= max_participants
  end

  def ws_free_places
    max_participants - workshop_participant_ids.count
  end

  def max_participants
    roomslot.try(:room).try(:size) || DEFAULT_MAX_WS_PARTICIPANTS
  end

end
