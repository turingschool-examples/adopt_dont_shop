require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'attributes' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:about) }
    it { should validate_presence_of(:status) }
  end

  describe 'relationships' do

    it {should have_many(:application_pets)}
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'model methods' do
    before(:each) do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @app = Application.create(name: "John Smith", address: "123 Main St", city: "Denver", state: "CO", zipcode: "80120", about: "I love a dogs. One please.", status: "Pending")
      ApplicationPet.create!(application_id: @app.id, pet_id: @pet_1.id)
      ApplicationPet.create!(application_id: @app.id, pet_id: @pet_3.id)
    end

    it '#list_pets - can find all pets that belong on an application' do
      expect(@app.list_pets.include?(@pet_1)).to eq(true)
      expect(@app.list_pets.include?(@pet_2)).to eq(false)
      expect(@app.list_pets.include?(@pet_3)).to eq(true)
    end
  end
end
