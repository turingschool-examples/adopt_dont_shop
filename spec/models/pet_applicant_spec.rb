require 'rails_helper'

RSpec.describe PetApplicant, type: :model do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'validations' do
    it { validate_presence_of :pet_id }
    it { validate_presence_of :applicant_id }
  end

  describe 'class methods' do
    describe '.find_app_status' do
      it 'can find the PetApplicant instance' do
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        # @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        # @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        
        @app_1 = Applicant.create!(name: "Billy Wahl", street_address: "123 S Street Way",
          city: "Denver", state: "CO", zip_code: "80123", description: "I Like Dogs", status: 'Pending')
    
        @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
        @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        # @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
        # @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
  
        pet_app1 = PetApplicant.create!(pet_id: @pet_1.id, applicant_id: @app_1.id)
        pet_app2 = PetApplicant.create!(pet_id: @pet_2.id, applicant_id: @app_1.id)
        
        expect(PetApplicant.find_app_status(@pet_1.id, @app_1.id)).to eq "In Progress"
      end
    end
  end
end