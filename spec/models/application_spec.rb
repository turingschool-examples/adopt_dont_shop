require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:application_pets)}
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

  describe 'instance methods' do
    before :each do
   		@application = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd",
  										  city: "Denver", state: "CO", zipcode: 80123)
  		@shelter = Shelter.create!(name: "Max Fund", city: "Denver", rank: 100, foster_program:true)
  		@pet_1 = @shelter.pets.create!(name: "Dianne", age: 3, breed: "cat?", adoptable: true)
      @pet_2 = @shelter.pets.create!(name: "Dianne_2", age: 3, breed: "cat?", adoptable: true)
  	end

    describe '#pets_added' do
      it 'lists all pets associated with application' do
        application_pet= ApplicationPet.create!(pet: @pet_1, application: @application)

        expect(@application.pets_added).to eq([@pet_1])
      end
    end

    describe '#application_pet_status' do
      it 'returns application_pet status if association is updated' do 
      @application_pet1 = ApplicationPet.create!(application: @application, pet: @pet_1)
      application_pet_updated = ApplicationPet.find(@application_pet1.id)
      application_pet_updated.status = 'approved'
      application_pet_updated.save
      expect(@application.application_pet_status(@pet_1.id)).to eq('approved')
      end
    end

      describe '#all_pets_reviewed?' do
        it 'returns true if all pets in an application has been approved/rejected' do 
           @application_pet1 = ApplicationPet.create!(application: @application, pet: @pet_1)
           @application_pet2 = ApplicationPet.create!(application: @application, pet: @pet_2)
            application_pet1_updated = ApplicationPet.find(@application_pet1.id)
            application_pet1_updated.status = 'approved'
            application_pet1_updated.save

            expect(@application.all_pets_reviewed?).to be false

            application_pet2_updated = ApplicationPet.find(@application_pet2.id)
            application_pet2_updated.status = 'rejected'
            application_pet2_updated.save

            expect(@application.all_pets_reviewed?).to be true
        end

      end

      describe '#all_pets_approved?' do 
    it 'returns true if all pets in an application has been approved' do 
           @application_pet1 = ApplicationPet.create!(application: @application, pet: @pet_1)
           @application_pet2 = ApplicationPet.create!(application: @application, pet: @pet_2)
            application_pet1_updated = ApplicationPet.find(@application_pet1.id)
            application_pet1_updated.status = 'approved'
            application_pet1_updated.save

            expect(@application.all_pets_approved?).to be false

            application_pet2_updated = ApplicationPet.find(@application_pet2.id)
            application_pet2_updated.status = 'approved'
            application_pet2_updated.save

            expect(@application.all_pets_approved?).to be true
        end

      end
 
  end
end
