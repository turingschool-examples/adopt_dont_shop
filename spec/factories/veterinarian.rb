FactoryBot.define do
  factory :veterinarian do
    on_call {Faker::Boolean.on_call}
    review_rating {Faker::Number.review_rating}
    breed {Faker::Name.breed}
    veterinary_office_id {Faker::Number.shelter_id}
  end
end
