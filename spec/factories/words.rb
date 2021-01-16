FactoryBot.define do
  factory :word do
    english  { "apple" }
    japanese { Faker::Lorem.sentence }
    remarks  { Faker::Lorem.sentence }
    association :user
  end
end
