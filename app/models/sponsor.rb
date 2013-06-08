class Sponsor < ActiveRecord::Base
  attr_accessible :description, :imageUrl, :name, :url

  validates_presence_of :name

  add_default_scheme :url, :imageUrl
end
