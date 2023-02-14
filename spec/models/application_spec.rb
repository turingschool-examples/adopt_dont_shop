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

    it 'counts the number of rejected or accepted applications' do 
      shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
      app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
      pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
      pet2 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Benedict McBark', shelter_id: shelter1.id,)
      pet3 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Gabe', shelter_id: shelter1.id,)
      petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id, status: "Accepted")
      petapplication2 = PetApplication.create!(pet_id: pet2.id, application_id: app1.id, status: "Accepted")
      petapplication3 = PetApplication.create!(pet_id: pet3.id, application_id: app1.id, status: "Rejected")

      expect(app1.application_status_count("Accepted")).to eq(2)
      expect(app1.application_status_count("Rejected")).to eq(1)
    end
  end
end