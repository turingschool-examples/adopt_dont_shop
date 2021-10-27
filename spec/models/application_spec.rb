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

  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @application = Application.create(name: 'Sam', address: '123 Main Street', city: 'Denver', state: 'CO', zip: '80204')
    @application.pets << @pet_1
  end

  describe 'class methods' do
  end

  describe 'instance methods' do
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

    describe '#all_pets_approved?' do
      it 'returns true only if every pet has been approved by an admin' do
        expect(@application.all_pets_approved?).to eq false

        PetApplication.find_by(pet_id: @pet_1.id).update(approved: true)

        expect(@application.all_pets_approved?).to eq true

        @pet_2 = @shelter_1.pets.create(name: 'Mrs. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
        @application.pets << @pet_2

        expect(@application.all_pets_approved?).to eq false

        PetApplication.find_by(pet_id: @pet_2.id).update(approved: true)

        expect(@application.all_pets_approved?).to eq true
      end
    end

    describe '#search_pets' do
      let(:application2) { Application.create(name: 'Sam', address: '123 Main Street', city: 'Denver', state: 'CO', zip: '80204') }

      it 'returns partial matches' do
        expect(application2.search_pets("pir")).to eq([@pet_1])
      end

      it 'doesnt return pets that have already been added' do
        application2.pets << @pet_1

        expect(application2.search_pets("pir")).to eq []
      end
    end
  end
end
