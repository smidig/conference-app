FactoryGirl.define do
  factory :talk do
    title 'Test Talk'
    description 'Test description'
    talk_type { FactoryGirl.create(:talk_type) }
    talk_category { FactoryGirl.create(:talk_category) }
  end
end
