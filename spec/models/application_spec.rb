require 'rails_helper'

describe Application do
  describe 'relationships' do
    it {should have_many(:pet_applications) }
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_length_of(:zip_code) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_numericality_of(:zip) }
    it { should validate_length_of(:zip) }
  end

  describe '#class methods' do
    describe '#pending_applications' do
      it 'returns applications where status is pending' do
        shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", status: "Pending")
        application2 = Application.create(name: 'Cruella', address: '123 S Leasy St', state: "Colorado", city: "Denver", zip: "80911", status: "Rejected")
        application3 = Application.create(name: 'Mr. Rogers', address: '123 SW Easy St', state: "Colorado", city: "Denver", zip: "80911", status: "Pending")
        pet_1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: shelter.id)
        PetApplication.create(pet_id: pet_1.id, application_id: application1.id, application_status: "Pending")
        PetApplication.create(pet_id: pet_1.id, application_id: application2.id, application_status: "Rejected")
        PetApplication.create(pet_id: pet_1.id, application_id: application3.id, application_status: "Pending")

        expect(Application.pending_applications).to eq([application1, application3])
      end
    end
  end

  describe 'instance methods' do
    describe '.has_pets' do
      it 'returns assesses whether the application has any pets' do
        shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Devin Pile', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911")
        pet1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: shelter.id)
        PetApplication.create(pet_id: pet1.id, application_id: application1.id)

        expect(application1.has_pets).to be true
      end
    end

    describe '.in_progress?' do
      it 'returns true if status equals in progress' do
        shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Devin Pile', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911")
        pet1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: shelter.id)
        expect(application1.in_progress?).to be true
      end
    end

    describe '.pending?' do
      it 'checks for pending status' do
        shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", status: "Pending")
        application2 = Application.create(name: 'Cruella', address: '123 SW Easy St', state: "Colorado", city: "Denver", zip: "80911", status: "Rejected")
        pet_1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: shelter.id)

        expect(application1.pending?).to be true
        expect(application2.pending?).to be false
      end
    end
  end
end