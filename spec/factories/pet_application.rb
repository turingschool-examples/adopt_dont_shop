FactoryBot.define do
  factory :pet_application, class: PetApplication do
    status { ['In Progress', 'Pending', 'Accepted', 'Rejected'].sample }
    association :pet, factory: :pet
    association :application, factory: :application
  end
end
