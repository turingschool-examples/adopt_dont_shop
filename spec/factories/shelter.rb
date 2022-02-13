FactoryBot.define do
  factory :shelter do

    foster_program    { true }
    name              { Faker::Kpop.ii_groups }
    city              { Faker::Address.city }
    rank              { Faker::Number.number(digits: 2) }
  end
end
