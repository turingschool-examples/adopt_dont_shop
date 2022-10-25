require 'rails_helper'

RSpec.describe PetApplicant, type: :model do 
  describe 'relationship' do 
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'validations' do 
    it { validate_presence_of :pet_id }
    it { validate_presence_of :applicant_id }
  end

  describe 'model methods' do 

    it 'should approve a pet on an applicant show page' do 
      shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)
      shelter6 = Shelter.create!(name: "ASPCA", city: "Las Vegas", rank: 3, foster_program: true)
      pet1 = shelter5.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
      pet2 = shelter6.pets.create!(name: "Sergio", breed: "Mutt", age: 16, adoptable: true)
      app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own", status: "Pending")
      app2 = Applicant.create!(name: "Kristen Nestler", street_address: "4786 Yankee Way", city: "New York", state: "NY", zip_code: "02134", description: "Being single is lonely.", status: "In Progress")
      pet_app1 = PetApplicant.create!(pet_id: pet1.id, applicant_id: @app1.id)
      pet_app2 = PetApplicant.create!(pet_id: pet2.id, applicant_id: @app2.id

        
      expect(pet_app1.approved_pet(pet1.id)).to eq([])
    end
  end
end