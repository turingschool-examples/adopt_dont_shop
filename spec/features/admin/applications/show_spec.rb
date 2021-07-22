require "rails_helper"

RSpec.describe "admin applications show page" do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @megan = Application.create!(name: "Megan", street_address: "12345 E street", city: "Phoenix", state: "AZ", zip_code: "99999", description: "Ipsum", status: "Pending")
    @pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)

    @megan.pets << @pirate
    # @megan.pets << @clawdia

    visit "/admin/applications/#{@megan.id}"
  end

  it "has button to approve" do
    expect(page).to  have_css('input[type="submit"][value="Approve This Pet"]')
  end

  xit "takes me back to show page and shows that pet approved" do
    click_button "Approve This Pet"

    expect(page).to eq("/admin/applications/#{@megan.id}")
    expect(page).to have_content("Mr. Pirate")
  end
end


# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
