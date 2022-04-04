# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
#And instead I see an indicator next to the pet that they have been approved
require 'rails_helper'

RSpec.describe "Admin applications Show" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", description: 'empty', status: "In Progress")

    @pet_1.applications << @application_1
    @pet_2.applications << @application_1
  end

  it "shows an admin application with pets to approve" do

    visit "/admin/applications/#{@application_1.id}"
    expect(current_path).to eq ("/admin/applications/#{@application_1.id}")
    click_button("Approve", match: :first)
    expect(page).to have_content("This pet has been approved!")

  end
end
