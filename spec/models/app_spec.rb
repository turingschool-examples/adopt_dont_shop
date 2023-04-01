require 'rails_helper'

RSpec.describe App, type: :model do
  describe 'relationships' do
    it {should have_many :app_pets}
    it {should have_many(:pets).through(:app_pets)}
  end

  describe 'instance methods' do
    before(:each) do
      @app_1 = App.create!(name: 'John Travolta', street_address: '1111 Greasy Lane', city: 'Frisco', state: 'CO', zip_code: '80678', description: 'I like dogs. Dogs are cool. You should give me a dog.', status: 'In Progress')
      @pet = Pet.create!(adoptable: true, age: 4, breed: 'Chihuahua', name: 'Maximus', shelter_id: @shelter_1.id)
    end

    it 'can add a pet to an applications pets' do
      expect(@app_1.pets.count).to eq(0)

      @app_1.apply_adopt(@pet)
      expect(@app_1.pets.count).to eq(1)
    end
  end
end