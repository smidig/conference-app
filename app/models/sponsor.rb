class Sponsor < ActiveRecord::Base
  attr_accessible :description, :imageUrl, :name, :url


  # validations
  validates_presence_of :name

  before_save :prefix_url_with_default_scheme, :if => :url_changed?

  private

  def prefix_url_with_default_scheme
    uri = URI.parse(self.url)
    self.url = "http://#{url}" if uri.scheme.nil?
  end
end
