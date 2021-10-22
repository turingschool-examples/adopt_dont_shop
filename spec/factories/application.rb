FactoryBot.define do
  factory :application, class: Application do
    name { Faker::Name.last_name }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    description { ['Love Animals', 'Kind', 'Want to Help', 'Loving Home', 'Good People'].sample }
  end
end
