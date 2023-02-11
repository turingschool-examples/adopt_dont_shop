require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe '.pets_list' do
    it 'should return a list of pets on the application' do
      app = Application.create!(name: 'John Smith',
        address: '123 Fake Street',
        city: 'Springfield',
        state: 'IL',
        zipcode: 12_345,
        description: 'I like dogs.',
        status: 'In Progress')
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
      bruno = shelter.pets.create!(
        adoptable: true,
        age: 3,
        breed: 'schnauzer',
        name: 'Bruno'
      )
      petapp1 = PetApplication.create!(application_id: app.id, pet_id: fido.id)
      petapp2 = PetApplication.create!(application_id: app.id, pet_id: bruno.id)
      expect(app.pets_list).to eq("#{fido.name}, #{bruno.name}")
    end
  end
end
