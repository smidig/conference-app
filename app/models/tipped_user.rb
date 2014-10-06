# -*- encoding : utf-8 -*-

class TippedUser < ActiveRecord::Base
  attr_accessible :email

  validates_uniqueness_of :email,
                          :message => "Denne brukeren er allerede tipset"

  validates_format_of :email,
                      :with => Devise.email_regexp,
                      :message => "Ugyldig format på e-post"
end
