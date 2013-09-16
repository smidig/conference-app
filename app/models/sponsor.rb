class Sponsor < ActiveRecord::Base
  attr_accessible :description, :imageUrl, :name, :url

  validates_presence_of :name

  add_default_scheme :url, :imageUrl

  after_save    :expire_sponsor_all_cache
  after_destroy :expire_sponsor_all_cache

  def self.all_cached
    Rails.cache.fetch('Sponsor.all') { all }
  end

  def expire_sponsor_all_cache
    Rails.cache.delete('Sponsor.all')
  end
end
