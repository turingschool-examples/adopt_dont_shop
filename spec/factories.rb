FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Number.number(digits: 5) }
    status { "In Progress" }
  end

  factory :shelter do
    name { Faker::Educator.campus }
    city { Faker::Address.city }
    foster_program { Faker::Boolean.boolean }
    rank { Faker::Number.number(digits: 1) }
    trait :with_pets do
      pets { build_list :pet, 3 }
    end
  end
  
  factory :pet do 
    name { Faker::FunnyName.name }
    age { Faker::Number.number(digits: 1) }
    breed { Faker::Creature::Dog.breed }
    adoptable { true }
    shelter
  end
  
  factory :veterinarian do
    name { Faker::Name.name }
    on_call { Faker::Boolean.boolean }
    review_rating { Faker::Number.between(from: 1, to: 10) }
    veterinary_office
  end

  factory :veterinary_office do
    name { Faker::University.suffix }
    max_patient_capacity { Faker::Number.between(from: 15, to: 30) }
    boarding_services { Faker:Boolean.boolean }
  end

  factory :application_pet do
    association :pet
    association :application
  end
end

# Build vs Create (build is destroyed after being used, better for tests?)
# application = build(:application)
# pet = build(:pet)
# shelter = build(:shelter)
# vetrinarian = build(:veterinarian)
# veterinary_office = build(:veterinary_office)
