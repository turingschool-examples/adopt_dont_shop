FactoryBot.define do
  factory :shelter do
    foster_program{[true,false].sample}
    name{Faker::Company.name }
    city{Faker::Address.city}
    rank {Faker::Number.between(from: 1, to: 40)}
  end
end
