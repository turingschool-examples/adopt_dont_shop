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

      expect(applicant_1.search_for_pet("Clawdia")).to eq([pet_2])
      expect(applicant_1.search_for_pet("clawdia")).to eq([pet_2])
      expect(applicant_1.search_for_pet("Geoff Dawg")).to eq("Pet name not in system")

    end

    it 'can serch for partial name matches' do 
      applicant_1 = Application.create!(name: "Joe", street_address: "123 House", city: "Denver", state: "CO", zipcode: 80220, description: "Dog dad", status: "In Progress")
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_3 = shelter_1.pets.create(name: 'Cornelius', breed: 'shorthair', age: 3, adoptable: true)
      pet_4 = shelter_1.pets.create(name: 'Lil Turtle', breed: 'shorthair', age: 10, adoptable: true)
      pet_5 = shelter_1.pets.create(name: 'Lil Possum', breed: 'shorthair', age: 2, adoptable: true)
      expect(applicant_1.search_for_pet("Corn")).to eq([pet_3])
      expect(applicant_1.search_for_pet("Nel")).to eq([pet_3])
      expect(applicant_1.search_for_pet("Lil")).to eq([pet_4, pet_5])
      expect(applicant_1.search_for_pet("Geoff Dawg")).to eq("Pet name not in system")
    end
  end
end