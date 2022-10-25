require 'rails_helper'

RSpec.describe PetApplicant, type: :model do
   describe 'relationships' do 
     it { should belong_to :pet}
     it { should belong_to :applicant}
   end

   describe 'class#methods' do 
    describe 'find_petapplicant' do 
      it 'finds pet applicant based on pet_id and applicant_id' do
        @applicant1 = Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", status: 'In Progress')
        @applicant2 = Applicant.create!(name: "Pink Flyod", street_address: "5150 High St", city: "Crater Lake", state: "None", zip: "12345", good_fit: "I need a companion")
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet1 = @shelter_1.pets.create!(adoptable: true, age: 4, breed: "Rotweiller", name: "Raider")
        @pet2 = @shelter_1.pets.create!(adoptable: true, age: 99, breed: "Chihuahua", name: "Yoda")
        @pet3 = @shelter_1.pets.create!(adoptable: true, age: 5, breed: "Parakeet", name: "Raider")
        @applicant1.pets << @pet1 
       
         expect(PetApplicant.find_petapplicant(@applicant1.id, @pet1.id).last.id).to eq(PetApplicant.first.id)
    end
   end
  end
end