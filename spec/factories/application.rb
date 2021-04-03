FactoryBot.define do
  factory :application, class: Application do
    name {Faker::Ancient.unique.god }
    address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state }
    zip_code { Faker::Address.zip_code }
    status { ["In Progress", "Pending", "Accepted", "Rejected"].sample }
     description { Faker::TvShows::MichaelScott.quote }
  end
end
