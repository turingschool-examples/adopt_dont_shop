FactoryBot.define do
  factory :veterinary_offices do
    boarding_services {Faker::Boolean.boarding_services}
    max_patient_capacity {Faker::Number.max_patient_capacity}
    shelter_id {Faker::Number.shelter_id}
  end
end
