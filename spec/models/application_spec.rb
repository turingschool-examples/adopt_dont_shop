require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}

  end

  describe '#adopt_pet' do
    it 'adds a pet to an application' do
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create(name: 'Scrappy', age: 2, breed: 'Terrior', adoptable: true, shelter_id: shelter.id)
      application = Application.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver',
       state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

      expect(application.pets).to eq([])

      application.adopt_pet(pet) 
      application.adopt_pet(pet2) 

      expect(application.pets).to eq([pet,pet2])
    end
  end

  describe '#order_app_pets_by_pets' do
    it 'aligns order of application pets with order of pets' do
      shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create!(name: 'Scrappy', age: 2, breed: 'Terrior', adoptable: true, shelter_id: shelter.id)
      application = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
      application.pets << pet2

      ordered_app_pets = application.order_app_pets_by_pets

      expect(ordered_app_pets).to eq(application.application_pets)

      application.application_pets.second.reject
      application.application_pets.first.reject

      still_ordered_app_pets = application.order_app_pets_by_pets

      expect(ordered_app_pets).to eq(still_ordered_app_pets)
    end
  end

  describe '#uniq_app_pets_status' do
    it 'returns array of unique application pet statuses for the application' do
      shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet2 = Pet.create!(name: 'Scrappy', age: 2, breed: 'Terrior', adoptable: true, shelter_id: shelter.id)
      application = pet.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
      application.pets << pet2

      expect(application.uniq_app_pets_status).to eq(["Pending"])

      application.application_pets.second.reject

      expect(application.uniq_app_pets_status).to eq(["Pending", "Rejected"])

      application.application_pets.first.reject

      expect(application.uniq_app_pets_status).to eq(["Rejected"])
    end
  end
end