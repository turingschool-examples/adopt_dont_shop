FactoryBot.define do
  factory :shelter, class: Shelter do
    foster_program {Faker::Boolean.boolean}
    name {[Faker::Company.name].uniq.sample}
    city {Faker::Address.city}
    rank {Faker::Number.between(from: 1, to: 100)}
  end
end
