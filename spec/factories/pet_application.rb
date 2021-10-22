FactoryBot.define do
  factory :pet_application, class: PetApplication do
    status { ['In Progress', 'Pending', 'Accepted', 'Rejected'].sample }
    description { ['Love Animals', 'Kind', 'Want to Help', 'Loving Home', 'Good People'].sample }
    association :pet, factory: :pet
    association :application, factory: :application
  end
end
