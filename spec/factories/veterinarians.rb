FactoryBot.define do
  factory :veterinarian do
    on_call {Faker::Boolean.boolean(true_ratio: 0.5)}
    review_rating {rand(1..5)}
    name {Faker::Name.name}
  end
end
