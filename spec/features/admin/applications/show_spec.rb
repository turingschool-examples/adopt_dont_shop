require 'rails_helper'

RSpec.describe 'admin applications show page' do
  before(:each) do
    @shelter_1     = create(:shelter)
    @pet_1         = create(:pet, shelter: @shelter_1)
    @application   = create(:application)
    @application.pets << @pet_1
  end
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
  it 'will have an approve button next to each pet' do
    visit "/admin/applications/#{@application.id}" 

    expect(page).to have_button("Approve")

    visit "/applications/#{@application.id}"

    expect(page).to_not have_button("Approve")
  end

  it 'When the pet is approved, it removes the button and states the pet is approved' do
    visit "/admin/applications/#{@application.id}" 

    click_button "Approve"

    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("This pet has been approved")
  end

  it 'When the pet is rejected, it removes the buttons and states the pet is rejected' do
    visit "/admin/applications/#{@application.id}" 

    click_button "Approve"

    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("This pet has been approved")
  end
end