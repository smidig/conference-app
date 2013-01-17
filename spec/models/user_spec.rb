require 'spec_helper'
describe User do
  describe ".new" do
    it "reuires users to have email" do
      user = User.new(:email => nil)
      user.invalid?.should be_true
      user.errors[:email].should be_true
      expect(user.errors[:email].join).to eq('can\'t be blank')
    end
    it "reuires users to have name" do
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
        :accepcted_privacy => true})
      user.valid?.should be_true
    end
  end
end
