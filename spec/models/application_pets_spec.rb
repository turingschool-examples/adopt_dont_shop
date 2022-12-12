require 'rails_helper'

RSpec.describe ApplicationPet do
  describe 'relationships' do
    it { should belong_to :application}
    it { should belong_to :pet}
  end

  describe '#approve' do
    it 'changes approved attribute to approved' do
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
      app_pet = pet1.application_pets.first

      app_pet.approve

      expect(app_pet.status).to eq("Approved")
    end
  end

  describe '#reject' do
    it 'changes approved attribute to rejected' do
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
      app_pet = pet1.application_pets.first

      app_pet.reject

      expect(app_pet.status).to eq("Rejected")
    end
  end

  describe '#find_by_pet_and_app()' do
    it 'returns a single ApplicationPet' do
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
      app_pet = pet1.application_pets.first
      application2 = pet1.applications.create!(name: 'John Smith', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

      expect(ApplicationPet.find_by_pet_and_app(pet1.id, application1.id)).to eq(app_pet)
    end
  end
end