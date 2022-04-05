require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @pet_3 = @shelter_2.pets.create(name: "Sherman", breed: "maine coon", age: 7, adoptable: true)
    @pet_4 = @shelter_2.pets.create(name: "Lucy", breed: "beagle", age: 2, adoptable: true)

    @pet_5 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name: "Anita Barker", street_address: '2468 Park Blvd.', city: "Denver", state: "CO", zipcode: "80202")
    @application_2 = Application.create!(name: "Frodo Baggins", street_address: '1 Shire Ave', city: "Denver", state: "CO", zipcode: "80202")

    @pet_app_1 = PetApplication.create(pet: @pet_1, application: @application_1)
    @pet_app_2 = PetApplication.create(pet: @pet_2, application: @application_1)
    @pet_app_3 = PetApplication.create(pet: @pet_3, application: @application_1, status: "Approved")
    @pet_app_4 = PetApplication.create(pet: @pet_1, application: @application_2)
    @pet_app_5 = PetApplication.create(pet: @pet_4, application: @application_2, status: "Rejected")
  end

  describe 'on index page' do
    it 'lists all the shelters in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end

  it 'shows the shelters with pending applications' do
    visit "/admin/shelters"

    expect(page).to have_content("Shelters with Pending Applications")
    within ".pending" do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_3.name)
      expect(page).not_to have_content(@shelter_2.name)
    end
  end
end
