FactoryBot.define do
  factory :veterinarian_office do
    on_call {[true,false].sample}
    review_rating {Faker::Number.between(from: 50, to: 200)}
    name {Faker::Beer.name}
  end
end
