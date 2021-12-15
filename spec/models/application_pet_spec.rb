require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  xit 'sets new ApplicationPets to Pending' do

    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    @application = Application.create!(
      name: "Joel Grant",
      street_address: "1234 Grant Road",
      city: "Littleton",
      state: "Colorado",
      zip: "80120",
      description: "I love dogs"
    )

    # require 'pry'; binding.pry
    ApplicationPet.create(pet_id: @pet_1.id, application_id: @application.id)
    # require 'pry'; binding.pry
    # ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
    # ApplicationPet.create!(pet_id: @pet_3.id, application_id: @application.id)
    expect(@application.status).to eq("Pending")
  end
end
