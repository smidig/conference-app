# Read about factories at https://github.com/thoughtbot/factory_girl
FactoryGirl.define do
  factory :talk_category do |tc|
    tc.name{ "MyString" }
    sequence(:abbreviation){|n| "MS#{n}" }
    tc.colour{ "#000000" }
  end
end
