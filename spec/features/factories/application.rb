FactoryBot.define do
  factory :application do
    name {Faker::Name.name}
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state_abbr}
    zip_code {Faker::Address.zip}
  end
end
