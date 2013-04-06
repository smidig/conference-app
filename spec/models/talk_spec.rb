# == Schema Information
#
# Table name: talks
#
#  id                        :integer          not null, primary key
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  title                     :string(255)
#  description               :text
#  talk_type_id              :integer
#  talk_category_id          :integer
#  presentation_file_name    :string(255)
#  presentation_content_type :string(255)
#  presentation_file_size    :integer
#  presentation_updated_at   :datetime
#

require 'spec_helper'

describe Talk do
  describe ".new" do
    it "should require a title" do
      talk = Talk.new(:title => nil)
      talk.errors[:name].should be_true
    end
    it "should require a description" do
      talk = Talk.new(:description => nil)
      talk.errors[:description].should be_true
    end
    it "should be valid with required fields" do
      talk = FactoryGirl.create(:talk)
      talk.valid?.should be_true
    end
  end
end
