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

  describe '#'
  
end