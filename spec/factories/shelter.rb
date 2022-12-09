FactoryBot.define do
  factory :shelter do
    foster_program {Faker::Boolean.foster_program}
    rank {Faker::Number.rank}
    city {Faker::Name.city}
    name {Faker::Name.name}
  end
end
