FactoryBot.define do
  factory :pet do
    adoptable { true }
    age { '4' }
    breed { "Hound" }
    name { "Bob" }
    shelter
  end
end
