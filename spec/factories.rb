FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    age { rand(0..15) }
    breed { Faker::Creature::Dog.breed }
    adoptable { Faker::Boolean.boolean }
  end

  factory :shelter do
    foster_program { Faker::Boolean.boolean }
    name { Faker::Company.name }
    city { Faker::Address.city }
    rank { rand(1..20) }
  end

  factory :application do
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.middle_name }
    last_name { Faker::Name.last_name }
    street_number { Faker::Number.number(digits: 5) }
    street_prefix { Faker::Compass.cardinal_abbreviation }
    street_name { Faker::Address.street_name }
    street_type { Faker::Address.street_suffix }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    description { ' ' }
    status { 'In Progress' }
  end

  factory :veterinarian do
    name { Faker::Name.name }
    on_call { Faker::Boolean.boolean }
    review_rating { rand(1..10) }
  end

  factory :veterinary_office do
    name { Faker::Company.name }
    boarding_services { Faker::Boolean.boolean }
    max_patient_capacity { rand(0..50) }
  end
end
