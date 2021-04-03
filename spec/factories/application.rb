FactoryBot.define do
  factory :application do
    name {Faker::Ancient.god }
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    association :shelter, factory: :shelter
  end
end
