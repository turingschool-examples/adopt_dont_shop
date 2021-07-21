require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @ann = @shelter_3.pets.create!(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @megan = Application.create!(name: "Megan", street_address: "12345 E street", city: "Phoenix", state: "AZ", zip_code: "99999", description: "Ipsum", status: "Pending")
    @danny = Application.create!(name: "Danny", street_address: "5678 W road", city: "Scottsdale", state: "AZ", zip_code: "88888", description: "lorem", status: "In Progress")
  end

  it 'see all Shelters in the system listed in reverse alphabetical order by name' do
    visit "admin/shelters"
    save_and_open_page


    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  xit "can see shelters with pending applications" do
    @megan.pets << @pirate
    @megan.pets << @ann
    @danny.pets << @clawdia

    visit "admin/shelters"

    expect(page).to have_content("Aurora shelter")
    expect(page).to have_content("Fancy pets of Colorado")
  end
end
