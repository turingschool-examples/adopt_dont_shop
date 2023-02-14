require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }

  let!(:pet_1) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry") }
  let!(:pet_2) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 1, breed: "Boston Terrier", name: "Fred") }

  let!(:application_1) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: [pet_1.name, pet_2.name]) }
  let!(:application_2) { Application.create!(name: "Holly", street_address: "2307 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "In Progress", pets_on_app: pet_1.name) }

  let!(:application_pet) { ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id) }
  let!(:application_pet_2) { ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id) }
  
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
    it { should define_enum_for(:pet_status).with_values(["Pending", "Accepted", "Rejected"])}
  end

  describe 'class methods' do
    it '::find_application_pet' do 
      expect(ApplicationPet.find_application_pet(pet_1.id, application_1.id)).to eq(application_pet)
    end
  end
end