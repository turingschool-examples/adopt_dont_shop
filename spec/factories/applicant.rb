FactoryBot.define do
  factory :applicant, class: Applicant do
    name { Faker::TvShows::Friends.unique.character  }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zipcode { Faker::Address.zip }
  end
end
