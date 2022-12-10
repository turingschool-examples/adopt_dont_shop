FactoryBot.define do
  factory :application do
    street_address {"#{rand(100..9999)} #{Faker::Book.name}"}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip_code {Faker::Address.zip_code}
    description {Faker::Book.title}
    name {Faker::Name.name}
  end
end
