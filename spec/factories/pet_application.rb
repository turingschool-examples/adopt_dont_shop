FactoryBot.define do
  factory :pet_application, class: PetApplication do
    status { ["In Progress", "Pending", "Accepted", "Rejected"].sample }
    cover_letter { Faker::TvShows::Simpsons.quote }

    association :pet, factory: :pet
    association :applicant, factory: :applicant
  end
end
