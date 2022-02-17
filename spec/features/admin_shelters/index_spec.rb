require 'rails_helper'

RSpec.describe "Admin Index" do
  before (:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create!(name: 'Da best pets', city: 'Lemont, NM', foster_program: true, rank: 10)
    @application = Application.create!(name: "Chaz Carmichael",
      street_address: "10 lane",
      city: "Sandy Springs",
      state: "CO",
      zipcode: 12345)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_4.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'dragon', name: 'Blake C', shelter_id: @shelter_1.id)
    @pet_application = PetApplication.create!(application_id: @application.id, pet_id: @pet_1.id)
    @pet_application1 = PetApplication.create!(application_id: @application.id, pet_id: @pet_2.id)
    @application.status = "1"
    @application.save
  end

  it "displays all Shelters in the system listed in reverse alphabetical order by name" do
    visit 'admin/shelters'

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_2.name)
  end

  it "displays Shelters with pending applications" do
    visit 'admin/shelters'
    expect(page).to have_content("Shelter's with Pending Applications:\n#{@shelter_1.name}\n#{@shelter_4.name}")
  end
end
