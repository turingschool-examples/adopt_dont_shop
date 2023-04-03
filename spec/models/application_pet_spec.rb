require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  before (:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_1 = @shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow')
    @pet_2 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Heisenberg', breed: 'calico', age: 7, adoptable: true)
    @application_1 = Application.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      description: "I like pets",
      status: "Pending"
  )
    @app_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @application_1)
  end

  describe 'relationships' do
    it{should belong_to :application}
    it{should belong_to :pet}
  end

  describe 'instance methods' do

    describe "find_name" do
      it "finds the name of the pet associated with an ApplicationPet record" do
        expect(@app_pet_1.find_name).to eq("Bare-y Manilow")
      end
    end
    
  end

  describe 'class methods' do

    describe "::findall" do
      it "takes an array of pets and a single application to return all matching ApplicationPets" do
        pets = [@pet_1,@pet_2,@pet_3]
        app_pets = ApplicationPet.findall(pets,@application_1)
        expect(app_pets.first.find_name).to eq(@pet_1.name)
      end
    end

  end

end