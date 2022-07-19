require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications)}
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Bubbles', breed: 'calico', age: 1, adoptable: true)
      @pet_4 = @shelter_1.pets.create(name: 'Andrew', breed: 'tabby', age: 1, adoptable: true)
      
      @application_1 = Application.create(name: 'John Smith', street_address: '123 Main St', city: 'Denver', state: 'CO', zipcode: '80206', description: 'I am a cat lover')
      @application_2 = Application.create(name: 'Jane Smith', street_address: '153 Main St', city: 'Denver', state: 'CO', zipcode: '80206', description: 'I am a dog lover')
      @application_3 = Application.create(name: 'Joe Smith', street_address: '1423 Main St', city: 'Denver', state: 'CO', zipcode: '80206', description: 'I am a dog and lover')
      
      @pet_application_1 = PetApplication.create(pet_id: @pet_1.id, application_id: @application_1.id, status: 'Pending')
      @pet_application_2 = PetApplication.create(pet_id: @pet_2.id, application_id: @application_1.id, status: 'Pending')
      @pet_application_3 = PetApplication.create(pet_id: @pet_3.id, application_id: @application_1.id ,status: 'Rejected')

      @pet_application_4 = PetApplication.create(pet_id: @pet_1.id, application_id: @application_2.id, status: 'Approved')
      @pet_application_5 = PetApplication.create(pet_id: @pet_2.id, application_id: @application_2.id, status: 'Rejected')

      @pet_application_6 = PetApplication.create(pet_id: @pet_1.id, application_id: @application_3.id, status: 'Approved')
      @pet_application_7 = PetApplication.create(pet_id: @pet_2.id, application_id: @application_3.id, status: 'Approved')
    end

    describe '#pending_pet_applications?' do
      it 'should return true if there are pending pet applications' do
        expect(@application_1.pending_pet_applications?).to eq(true)
      end
      it 'should return false if there are no pending pet applications' do
        expect(@application_2.pending_pet_applications?).to eq(false)
        expect(@application_3.pending_pet_applications?).to eq(false)
      end
    end

    describe '#any_rejected_pet_applications?' do
      it 'should return true if there are rejected pet applications' do
        expect(@application_1.any_rejected_pet_applications?).to eq(true)
        expect(@application_2.any_rejected_pet_applications?).to eq(true)
      end
      it 'should return false if there are no rejected pet applications' do
        expect(@application_3.any_rejected_pet_applications?).to eq(false)
      end
    end

    describe '#all_accepted_pet_applications?' do
      it 'should return true if all pet applications are approved' do
        expect(@application_3.all_accepted_pet_applications?).to eq(true)
      end
    end

    describe '#reject_application' do
      it "should change the application's status to 'Rejected'" do
        @application_1.reject_application
        expect(@application_1.app_status).to eq('Rejected')
      end
    end

    describe '#approve_application' do
      it "should change the application's status to 'Approved'" do
        @application_1.approve_application
        expect(@application_1.app_status).to eq('Approved')
      end
    end
end