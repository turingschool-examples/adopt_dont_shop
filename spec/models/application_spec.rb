require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Erika Kischuk", address: "455 Villa Ct. Morrison, CO 80228", description: "I love animals", status: "In Progress")
  end
  describe 'relationships' do
    it {should have_many(:application_pets)}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:status)}
  end


  describe 'instance methods' do
    it 'pet_count' do
      expect(@app_1.pet_count).to eq(0)
      @app_1.pets << @pet_1
      @app_1.pets << @pet_2
      expect(@app_1.pet_count).to eq(2)
    end
  end
end
