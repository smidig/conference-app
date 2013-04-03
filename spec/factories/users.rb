FactoryGirl.define do
  factory :user do |u|
    u.name 'Test User'
    u.sequence(:email) { |n| "test#{n}@awesome.com"}
    u.password 'please123445'
    u.tlf '99900999'
    u.accepcted_privacy true
    u.ticket { FactoryGirl.create(:ticket) }
  end

  factory :admin, class: User do |u|
    u.name 'Test Admin User'
    u.sequence(:email) { |n| "test#{n}@awesome.com"}
    u.password 'please123445'
    u.tlf '99900999'
    u.accepcted_privacy true
    u.ticket { FactoryGirl.create(:ticket) }
    u.admin true
  end
end