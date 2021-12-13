require 'rails_helper'

RSpec.describe "admins application show page" do
#   As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
  it 'it lists every pet that the application is for' do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    derek = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 }, status: "Pending")

    derek.pets << @pet_1
    derek.pets << @pet_3
    derek.pets << @pet_4

    visit "/admin/applications/#{derek.id}"

    expect(page).to have_button("Approve Pet")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_3.name)
    expect(page).to have_content(@pet_4.name)
    expect(page).to_not have_content(@pet_2.name)

    find(".approve-#{@pet_1.id}").click

    expect(page).to have_content("Approved Pets #{@pet_1.name}")

    expect(page).to_not have_css(".approve-#{@pet_1.id}")

    find(".approve-#{@pet_3.id}").click

    expect(page).to have_content("Approved Pets #{@pet_3.name}")
  end
end
