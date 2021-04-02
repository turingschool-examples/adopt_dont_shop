FactoryBot.define do
  factory :shelter do
    name {"#{Faker::Address.community} Animal Shelter"}
    city {Faker::Address.city}
    foster_program {Faker::Boolean.boolean}
    rank {[0..5].sample]}
  end
end
