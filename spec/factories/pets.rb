FactoryBot.define do
  factory :pet do
    adoptable {Faker::Boolean.boolean(true_ratio: 0.5)}
    age {rand(0..50)}
    breed {["Tabby", "Lab", "Terrier", "Siamese"].sample}
    name {Faker::Name.first_name}
  end
end
