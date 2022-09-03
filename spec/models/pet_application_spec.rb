require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :application}
  end

  describe "Class methods" do
    it "should find all pet applications with pending status" do
      happypaws = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      fluffy = happypaws.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      samantha_application = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "Pending")
      fluffy_application = PetApplication.create!(pet: fluffy, application: samantha_application)

      saving_pets_shelter = Shelter.create!(name: "Saving Pets Shelter", foster_program: true, city: "New York", rank: 3)
      pet3 = saving_pets_shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")
      bill_application = Application.create!(first_name: "Bill", last_name: "Rollands", street_address: "123 Street Street", city: "Denver", state: "CO", zip_code: 24628, description: "I would like this dog.", status: "Pending")
      fluffy_application = PetApplication.create!(pet: pet3, application: bill_application)

      expect(PetApplication.pending_pets).to eq([fluffy, pet3])

    end
  end
end
