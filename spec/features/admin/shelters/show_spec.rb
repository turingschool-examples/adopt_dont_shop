equire 'rails_helper'

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
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    shelters = Shelter.all
    visit "/admin/shelters"
    # save_and_open_page
    # expect(shelters.count).to eq(3)
    # expect(Shelter.names_sorted.first.name).to eq('RGV animal shelter')
    # expect(Shelter.names_sorted.last.name).to eq('Aurora shelter')
  end
end
