require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "User must specify email" do
      user = User.new(:email => nil)
      assert user.invalid?
      assert user.errors[:email]
      assert_equal 'can\'t be blank', user.errors[:email].join
   end

   test "User must specify name" do
      user = User.new(:name => nil)
      assert user.invalid?
      assert user.errors[:name]
      assert_equal 'can\'t be blank', user.errors[:name].join
   end

  test "User must specify tlf" do
      user = User.new(:tlf => nil)
      assert user.invalid?
      assert user.errors[:tlf]
      assert_equal 'can\'t be blank', user.errors[:tlf].join
   end

  test "User must accept privacy" do
      user = User.new(:accepcted_privacy => nil)
      assert user.invalid?
      assert !(user.errors[:accepcted_privacy].join).blank?
  end
end
