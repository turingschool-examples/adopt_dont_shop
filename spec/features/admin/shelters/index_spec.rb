require 'rails_helper'

RSpec.describe 'Admin Shelters homepage' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: "Buster", adoptable: true, age: 2, breed: "Black Lab")
    @pet_2 = @shelter_2.pets.create!(name: "Minnie", adoptable: false, age: 2, breed: "Chow")
    @pet_3 = @shelter_2.pets.create!(name: "Busted", adoptable: true, age: 6, breed: "Bulldog")
    # @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    # @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    # @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application = Application.create!(
      name: "Joel Grant",
      street_address: "1234 Grant Road",
      city: "Littleton",
      state: "Colorado",
      zip: "80120"
    )
    @application_2 = Application.create!(
      name: "Peter Griffin",
      street_address: "1098 Spooner Street",
      city: "Quahog",
      state: "Rhode Island",
      zip: "12345"
    )
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)
    visit "/admin/shelters"
  end

  describe 'when I visit the admin shelter index page' do
    it 'displays all Shelters in the system listed in reverse alphabetical order' do
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end

    it 'has a section called Shelters with Pending Applications' do
      expect(page).to have_content("Shelters with Pending Applications")
    end

    xit 'shows the name of all pending applications' do
      expect(page).to have_content("Aurora Shelter")
      expect(page).to have_content("RGV animal shelter")
    end
  end
end
