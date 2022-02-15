FactoryBot.define do
  factory :adoption_form do

    first_name      { Faker::Name.first_name }
    last_name       { Faker::Name.last_name }
    street_address  { Faker::Address.street_address }
    city            { Faker::Address.city }
    state           { Faker::Address.state }
    zip_code        { Faker::Address.zip_code }
    status          { 0 }
  end
end
