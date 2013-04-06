# == Schema Information
#
# Table name: sponsors
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  url         :string(255)
#  imageUrl    :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sponsor < ActiveRecord::Base
  attr_accessible :description, :imageUrl, :name, :url


  # validations
  validates_presence_of :name
  # Legg på http hvis det mangler på url
end
