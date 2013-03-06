require 'spec_helper'

describe Sponsor do
	describe ".new" do
		it "requires sponsors to have a name" do
			sponsor = Sponsor.new
			sponsor.invalid?.should be_true
		end
	end
end
