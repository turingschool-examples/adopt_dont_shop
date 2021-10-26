require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  describe 'instance methods' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      @application = Application.create(name: 'Sam', address: '123 Main Street', city: 'Denver', state: 'CO', zip: '80204')
      @application.pets << @pet_1
    end

    it '#find_pet_application returns the pet_application for a given pet_id' do
      expect(@application.find_pet_application(@pet_1.id)).to be_a PetApplication
      expect(@application.find_pet_application(@pet_1.id).approved).to be nil
    end

    describe '#approved' do
      it 'returns nil if an application has not been reviewed by an admin' do
        expect(@application.approved(@pet_1.id)).to be nil
      end

      it 'returns true or false if an application has been reviewed by an admin' do
        @application.find_pet_application(@pet_1.id).update(approved: true)

        expect(@application.approved(@pet_1.id)).to eq true
      end
    end
  end
end
