# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string(255)      default(""), not null
#  encrypted_password      :string(255)      default(""), not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0)
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :string(255)
#  last_sign_in_ip         :string(255)
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  admin                   :boolean
#  name                    :string(255)
#  tlf                     :string(255)
#  company                 :string(255)
#  accepcted_privacy       :boolean
#  accepted_optional_email :boolean
#  twitter                 :string(255)
#  allergies               :string(255)
#  ticket_id               :integer
#  order_id                :integer
#  completed               :boolean
#

require 'spec_helper'
describe User do
  describe ".new" do
    it "requires users to have email" do
      user = User.new(:email => nil)
      user.invalid?.should be_true
      user.errors[:email].should be_true
      expect(user.errors[:email].join).to eq('can\'t be blank')
    end
    it "requires users to have name" do
      user = User.new(:name => nil)
      user.invalid?.should be_true
      user.errors[:name].should be_true
      expect(user.errors[:name].join).to eq('can\'t be blank')
    end
    it "should be valid with required fields" do
      user = User.new({
        :name => "Tester",
        :email => "me@mail.com",
        :tlf => "92043382",
        :password => "lala12345",
        :accepted_privacy => "1"})
      user.valid?.should be_true
    end
  end
end
