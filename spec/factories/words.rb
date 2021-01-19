FactoryBot.define do
  factory :word do
    english  { Faker::Lorem.word }
    japanese { Faker::Lorem.sentence }
    remarks  { Faker::Lorem.sentence }
    association :user
  end
end
