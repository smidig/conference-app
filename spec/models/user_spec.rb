require 'spec_helper'
describe User do
  describe ".new" do
    it "reuires users to have email" do
      user = User.new(:email => nil)
      expect user.invalid?
      expect user.errors[:email]
      expect(user.errors[:email].join).to eq('can\'t be blank')
    end
  end
end
