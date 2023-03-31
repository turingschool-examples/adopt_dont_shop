require 'rails_helper'

RSpec.describe 'admin shelters' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_1 = @shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow')
    @application_1 = @pet_1.applications.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      status: "",
      description: "I like pets",
      status: "Pending"
  )
  end

  it 'shows shelters with pending applications' do
    visit '/admin/shelters' 
    expect(page).to have_content("#{@shelter_1.name}")
  end
end


# For this story, you should fully leverage ActiveRecord methods in your query.

# 11. Shelters with Pending Applications

# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelters with Pending Applications"
# And in this section I see the name of every shelter that has a pending application