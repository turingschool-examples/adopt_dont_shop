FactoryBot.define do
  factory :veterinary_office do
    boarding_services {Faker::Boolean.boolean(true_ratio: 0.5)}
    max_patient_capacity {rand(20..50)}
    name {Faker::Book.title}
  end
end
