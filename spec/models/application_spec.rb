require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end
  describe 'instance methods' do
    it 'can list associated pet names' do
      furry = Shelter.create!(name:'Furrry Shelter', foster_program: true, city: 'New Orleans', rank: 5)

      lana = furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')
      doc = furry.pets.create!(name: 'Doc', age: 8, adoptable: true, breed: 'schnauzer')

      application1 = Application.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I love my furry friends and have a great yard they can roam around in', status: 'pending')

      application1.pets << [lana, doc]

      expect(application1.associated_pets(application1.id)).to eq([lana, doc])
    end
  end
end
