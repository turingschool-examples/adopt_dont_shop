FactoryBot.define do
  factory :veterinarian do
    on_call {[true,false].sample}
    review_rating {Faker::Number.between(from: 1, to: 5)}
    name {Faker::DcComics.villain}
    association :veterinary_office_id, factory: :veterinary_office_id
  end
end
