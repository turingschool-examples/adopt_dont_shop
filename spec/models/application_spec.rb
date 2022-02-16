require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
  end

  describe 'instance methods' do
    describe 'application status' do
      before :each do
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @pet_2 = shelter_1.pets.create!(name: 'Gaspir', breed: 'shorthair', age: 3, adoptable: true)
        @app_1 = Application.create!(
          name: "Jerry Blank",
          street_address: "246 DumDum Ave.",
          city: "Melbourne",
          state: "IL",
          zip_code: 53262,
          status: "In Progress"
        )
      end

      it 'applications with no pets added have a status of In Progress' do
        expect(@app_1.status_check).to eq("In Progress")
      end

      it 'applications with pets added but none approved or rejected have a status of Pending' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id)
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id)
        expect(@app_1.status_check).to eq("Pending")
      end

      it 'applications with some pets approved have a status of Pending' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id, status: "Approved")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id)
        expect(@app_1.status_check).to eq("Pending")
      end

      it 'applications with all pets approved have a status of Approved' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id, status: "Approved")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id, status: "Approved")
        expect(@app_1.status_check).to eq("Approved")
      end

      it 'applications with some pets rejected have a status of Pending' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id, status: "Rejected")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id)
        expect(@app_1.status_check).to eq("Pending")
      end

      it 'applications with all pets rejected have a status of Rejected' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id, status: "Rejected")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id, status: "Rejected")
        expect(@app_1.status_check).to eq("Rejected")
      end

      it 'applications with all pets rejected & approved have a status of Rejected' do
        PetApplication.create!(pet_id: @pet_1.id, application_id: @app_1.id, status: "Rejected")
        PetApplication.create!(pet_id: @pet_2.id, application_id: @app_1.id, status: "Approved")
        expect(@app_1.status_check).to eq("Rejected")
      end
    end
  end
end
