require 'rails_helper'

RSpec.describe Application do 
  before(:each) do 
    applicant_1 = Application.create!(name: "Joe", street_address: "123 House", city: "Denver", state: "CO", zipcode: 80220, description: "Dog dad", status: "In Progress")
  end
  describe 'it exists' do 
    it {should validate_presence_of :name } 
    it {should validate_presence_of :street_address } 
    it {should validate_presence_of :city } 
    it {should validate_presence_of :state } 
    it {should validate_presence_of :zipcode } 
    it {should validate_presence_of :description } 
  end

  describe '#search_for_pet' do 
    it 'searches for a pet name and returns that pet if found' do
      applicant_1 = Application.create!(name: "Joe", street_address: "123 House", city: "Denver", state: "CO", zipcode: 80220, description: "Dog dad", status: "In Progress")
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

      expect(applicant_1.search_for_pet("Clawdia")).to eq(pet_2)
      expect(applicant_1.search_for_pet("clawdia")).to eq(pet_2)
      expect(applicant_1.search_for_pet("Geoff Dawg")).to eq("Pet name not in system")

    end
  end
end