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

require 'spec_helper'

describe Sponsor do
	describe ".new" do
		it "requires sponsors to have a name" do
			sponsor = Sponsor.new
			sponsor.invalid?.should be_true
		end
	end
end
