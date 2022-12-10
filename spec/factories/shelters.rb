FactoryBot.define do
  factory :shelter do
    foster_program {Faker::Boolean.boolean(true_ratio: 0.5)}
    rank {rand(0..50)}
    city {Faker::Address.city}
    name {Faker::Book.title}
  end
end
