require 'rails_helper'

RSpec.describe App, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:app_pets) }
  end

  describe 'validations' do
    
  end

  describe 'adopt' do
    it 'adds a pet to self.pets' do
      @craigs = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE", foster_program: 'false')
      @trash = @craigs.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
      @princess = @craigs.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
      @beldof = @craigs.apps.create!(
        name: "Gob Beldof", 
        address: "152 Animal Ave.", 
        city: "Omaha, NE", 
        zip_code: "19593",
        description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
        status: "Pending"
      )
      @beldof.adopt(@trash)
      @beldof.adopt(@princess)
      expect(@beldof.pets).to include(@trash, @princess)
    end
  end
end