FactoryBot.define do
  factory :application, class: Application do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    description { Faker::Creature::Dog.meme_phrase }
  end
end
