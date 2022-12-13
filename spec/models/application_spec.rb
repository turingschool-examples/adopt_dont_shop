require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
    it { should have_many(:shelters).through(:pets) }
  end

  describe 'instance methods' do
    before :each do
      @shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

      @james = @shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
      @buster = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
      @marlowe = @shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

      @app1 = Application.create!(
        name: 'Frank Sinatra',
        street_address: '69 Sinatra Way',
        city: 'Nashville',
        state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs",
        status: 'Pending'
      )
    end
  end
end
