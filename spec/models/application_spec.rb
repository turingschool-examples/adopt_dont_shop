require 'rails_helper'


RSpec.describe Application do

  describe 'relationships' do
    it { should have_many(:pet_applications)}
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'methods' do
    it 'can tell if no pets' do
      app = Application.create!(name: 'Hugh',
        city: 'Aurora',
        street_address: '300 quebec st',
        state: 'CO',
        zip: 12345
      )
      shelter = Shelter.create!(foster_program: true,
        name: 'Bundle park',
        city: 'Denver',
        rank: 3
      )
      dog1 = shelter.pets.create!(adoptable: true,
        age: 2,
        breed: 'yes',
        name: 'Bob'
      )

      expect(app.dogs?).to eq(false)

      app.pets << dog1

      expect(app.dogs?).to eq(true)
    end
  end

end
