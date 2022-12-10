FactoryBot.define do
  factory :application do
    street_address {"#{rand(100..9999)} #{Faker::Name.first_name}"}
    city {Faker::Address.city}
    state {Faker::Address.state}
    zip_code {Faker::Address.zip_code}
    description {Faker::Book.title}
    status {[0, 1, 2, 3].sample}
    name {Faker::Name.name}
  end
end
