require 'rails_helper'

RSpec.describe 'the admin/shelters show page' do

  #   [ ] done
  #
  # Approving a Pet for Adoption
  #
  # As a visitor
  # When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved


  it "shows the Shelters in reverse alphabetical order" do
    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave Parker, CO 80134', description: nil, status: "In Progress" )
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)

    visit "/applications/#{application_one.id}"

    fill_in( "pet_of_interst_name", with: "Lucille Bald")
    click_on("Find")
    click_on("Adopt Lucille Bald")
    fill_in( "description", with: "I would love a new friend.")
    click_on("Submit Adoption Form")
    visit "/admin/applications/#{application_one.id}"
    # save_and_open_page
    click_on("Approve Lucille Bald")
    expect(current_path).to eq("/admin/applications/#{application_one.id}")
    expect(page).to have_content("Lucille Bald was Approved")
  end
end
