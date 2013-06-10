FactoryGirl.define do
  factory :ticket do
    name 'Early bird ticket'
    price 200
    active true
    ticket_type 'regular'
  end

  factory :free_ticket, :parent => :ticket do
    ticket_type 'free'
  end
end
