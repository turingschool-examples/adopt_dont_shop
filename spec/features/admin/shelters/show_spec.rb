require 'rails_helper'

RSpec.describe "Admin Shelter Show" do

  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create(name: 'Alex Horn', street_address: '12 Not A Real Ln', city: 'Westminster', state: 'CO', zip_code: '80021')
    @pets_applications_1 = ApplicationsPet.create!(pet_id: @shelter_1.pets[0].id, application_id: @application_1.id)
    @pets_applications_2 = ApplicationsPet.create!(pet_id: @shelter_3.pets[0].id, application_id: @application_1.id)
  end

  it "displays individual shelter's name and full address" do
    visit "/admin/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.city)
    expect(page).not_to have_content(@shelter_1.rank)
  end
end