require 'rails_helper'

RSpec.describe "the admin shelter index page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application_1 = Application.create!(name: "Chris",
                                        street_address: "19072",
                                        city: "Exeter",
                                        state: "CA",
                                        zip: 93221,
                                        status: "Pending")
    @application_1.add_pet(@pet_1)
                                
    @application_2 = Application.create!(name: "Raed",
     street_address: "1640 Burwood",
     city: "Melbourne",
     state: "CA",
     zip: 93221,
     status: "Pending")
    # for terminal foolin
  end
  it "displays all the shelters in reverse alphabetical order" do
    visit "/admin/shelters"
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
  end

  it "displays all shelters with pending applications" do
    visit "/admin/shelters"
    expect(page).to have_content("Shelters with Pending Applications")
    save_and_open_page

  end
end