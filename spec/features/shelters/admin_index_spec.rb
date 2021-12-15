require 'rails_helper'

RSpec.describe 'admin shelters index page' do
  before(:each) do
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
      description: "I love dogs",
      status: "Pending"
    )

    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    ApplicationPet.create!(pet_id: @pet_3.id, application_id: @application.id)

  end

  describe 'when I go to the admin shelters index page' do
    it 'has all the shelters listed in reverse alphabetical order' do
      visit "/admin/shelters"

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end

    it 'has a section for pending applications' do
      visit "/admin/shelters"

      expect(page).to have_content("Shelters with Pending Applications")
    end

    it 'has a section where the pending applications are listed' do
      visit "/admin/shelters"

      within "#pending" do
        expect(page).to have_content("#{@shelter_1.name}")
        expect(page).to have_content("#{@shelter_3.name}")
      end
    end

    # it 'does not return any shelter names if none have pending apps' do
    #   visit "/admin/shelters"
    #
    #   within "#pending" do
    #     expect(page).to_not have_content("#{@shelter_1.name}")
    #     expect(page).to_not have_content("#{@shelter_3.name}")
    #   end
    # end
  end
end
