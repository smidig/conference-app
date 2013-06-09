FactoryGirl.define do
  factory :ticket do
    name 'Early bird ticket'
    price 200
    active true
    ticket_type 'regular'
  end
end
