require 'rails_helper'

RSpec.describe Application, type: :model do
  before :each do
    @application_1 = Application.create!(name: 'John Doe', address: '123 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals!', status: 0)
    @application_2 = Application.create!(name: 'Jane Doe', address: '456 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals!', status: 1)
    @application_3 = Application.create!(name: 'John Smith', address: '789 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I eat animals!', status: 2)
    @application_4 = Application.create!(name: 'Jane Smith', address: '101 Main St', city: 'Denver', state: 'CO', zip: '80202', description: 'I hate animals!', status: 3)
  end
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
    it { should validate_presence_of(:description) }
  end

  describe 'enum' do
    it 'has an enum for status' do
      expect(Application.statuses).to eq({"In Progress" => 0, "Pending" => 1, "Accepted" => 2, "Rejected" => 3})
    end

    it 'enum has a default status of In Progress' do
      expect(@application_1.status).to eq('In Progress')
    end

    it 'enum has a status of Pending' do
      expect(@application_2.status).to eq('Pending')
    end

    it 'enum has a status of Accepted' do
      expect(@application_3.status).to eq('Accepted')
    end

    it 'enum has a status of Rejected' do
      expect(@application_4.status).to eq('Rejected')
    end
  end

  describe 'instance methods' do
    let!(:application_1) { Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 1) }

    let!(:shelter) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

    let!(:bella) { shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) }
    let!(:rigby) { shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) }

    let!(:pet_app_1) { PetApplication.create!(pet: bella, application: application_1) }
    let!(:pet_app_2) { PetApplication.create!(pet: rigby, application: application_1) }

    describe '#has_pending_pets' do
      it 'returns true if an application has pets that have not been approved or rejected' do
        expect(application_1.has_pending_pets?).to be true
      end

      it 'returns false if all pets for the application have been approved or rejected' do
        pet_app_1.update(approved: true)
        pet_app_2.update(approved: true)

        expect(application_1.has_pending_pets?).to be false
      end
    end

    describe '#has_rejected_pets?' do
      it 'returns true if any pet on an application was rejected' do
        pet_app_1.update(approved: false)

        expect(application_1.has_rejected_pets?).to be true
      end

      it 'returns false if no pet on an application was rejected' do
        expect(application_1.has_rejected_pets?).to be false

        pet_app_1.update(approved: true)
        pet_app_2.update(approved: true)

        expect(application_1.has_rejected_pets?).to be false
      end
    end
  end
end