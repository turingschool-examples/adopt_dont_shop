FactoryBot.define do
  factory :application, class: Application do
    name { Faker::Name.unique.name  }
    address { Faker::Address.building_number  }
    street { Faker::Address.street_name  }
    city  { Faker::Address.city }
    state  { Faker::Address.state_abbr }
    zip_code  { Faker::Number.number(digits: 5) }
    description { "I really like dogs a lot" }
    status { "In Progress" }
  end
end
