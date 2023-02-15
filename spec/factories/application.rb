FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zipcode { Faker::Number.number(digits: 5) }
    description { "I like dogs." }
  end
end
