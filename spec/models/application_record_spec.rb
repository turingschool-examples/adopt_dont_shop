# spec/models/application_spec.rb
require 'rails_helper'

RSpec.describe ApplicationRecord, type: :model do

  it "can search regardless of capitalization or partials" do
    shelter_1 = Shelter.create!(name: 'Big Dogs Huge Paws', city: 'Fort Collins', foster_program: false, rank: 11)
    pet_1 = shelter_1.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true)

    expect(Pet.search_for("cass")).to eq([pet_1])
  end
end
