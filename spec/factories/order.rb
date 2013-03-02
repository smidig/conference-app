FactoryGirl.define do
  factory :order do |o|
    o.owner_user_id { FactoryGirl.create(:user) }
  end
end