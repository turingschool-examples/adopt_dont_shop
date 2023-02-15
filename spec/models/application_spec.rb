require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe '#pet_application_by_pet' do
    it 'returns the pet application for a given pet' do
      app = Application.create!(
        name: 'John Smith',
        address: '123 Fake Street',
        city: 'Springfield',
        state: 'IL',
        zipcode: 12_345,
        description: 'I like dogs.',
        status: 'In Progress'
      )
      shelter = Shelter.create!(
        foster_program: true,
        name: 'Dog house',
        city: 'Springfield',
        rank: 1
      )
      fido = shelter.pets.create!(
        adoptable: true,
        age: 1,
        breed: 'weiner',
        name: 'Fido'
      )
      petapp1 = PetApplication.create!(application_id: app.id, pet_id: fido.id)

      expect(app.pet_application_by_pet(fido)).to eq(petapp1)
    end
  end
end
