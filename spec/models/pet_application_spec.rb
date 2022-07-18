require "rails_helper"

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe 'class methods' do 
  
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      @petapp1 = PetApplication.create!(pet: @pet_1, application: @application_1, app_status: "Approved")
      @petapp2 = PetApplication.create!(pet: @pet_2, application: @application_1, app_status: "Approved")
      @petapp3 = PetApplication.create!(pet: @pet_3, application: @application_1, app_status: "Rejected")
    end

    describe 'self.find_pet_app' do 
      it 'finds a pet app' do 
        expect(PetApplication.find_pet_app(@pet_1.id, @application_1.id)).to eq(@petapp1)
      end 
    end 

    describe 'self.pet_app_count' do 
      it 'find the number of pets on a pet app' do 
        expect(PetApplication.pet_app_count(@application_1.id)).to eq(3)
      end 
    end 

    describe 'self.pet_app_approved_count' do 
      it 'finds the count of approved pets on an app' do 
        expect(PetApplication.pet_app_approved_count(@application_1.id)).to eq(2)
      end 
    end 

    describe 'self.pet_app_rejected_count' do 
      it 'finds the count of rejected pet on an app' do 
        expect(PetApplication.pet_app_rejected_count(@application_1.id)).to eq(1)
      end 
    end 
  end 
end