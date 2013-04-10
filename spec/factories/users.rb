FactoryGirl.define do
  factory :user do |u|
    u.name 'Test User'
    u.sequence(:email) { |n| "test#{n}"+rand(1000).to_s+"@awesome.com"}
    u.password 'please123445'
    u.tlf '99900999'
    u.accepted_privacy "1"
    u.ticket { FactoryGirl.create(:ticket) }
  end

  factory :admin, class: User do |u|
    u.name 'Test Admin User'
    u.sequence(:email) { |n| "test#{n}"+rand(1000).to_s+"@awesome.com"}
    u.password 'please123445'
    u.tlf '99900999'
    u.accepted_privacy "1"
    u.ticket { FactoryGirl.create(:ticket) }
    u.admin true
  end
end
