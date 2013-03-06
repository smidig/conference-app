class Sponsor < ActiveRecord::Base
  attr_accessible :description, :imageUrl, :name, :url


  # validations
  validates_presence_of :name
  # Legg på http hvis det mangler på url
end
