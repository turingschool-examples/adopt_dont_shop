FactoryBot.define do
  factory :application do
    name { Faker::Name.name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Number.number(digits: 5) }
    description { Faker::Lorem.sentence }
    status { :in_progress }
  end

  factory :pet do 
    name { Faker::FunnyName.name }
    age { Faker::Number.number(digits: 1) }
    breed { Faker::Creature::Dog.breed }
    adoptable { true }
  end
end
# application = build(:application)
# pet = build(:pet)
# shelter = build(:shelter)
# vetrinarian = build(:veterinarian)
# veterinary_office = build(:veterinary_office)