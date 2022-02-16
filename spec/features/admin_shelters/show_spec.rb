require 'rails_helper'

RSpec.describe "Admin Shelter Show Page" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create!(name: 'Da best pets', city: 'Lemont, NM', foster_program: true, rank: 10)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'dragon', name: 'Blake C', shelter_id: @shelter_1.id)
  end

  xit "displays shelter's name and full address" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
  end

  it "displays average age of all adoptable pets" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Average Age of Adoptable Pets: 2.0")
  end

  it "displays number of pets at a shelter that are adoptable" do
    visit "/admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content("Number of Adoptable Pets: 2")
  end
end
