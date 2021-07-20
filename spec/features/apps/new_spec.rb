require 'rails_helper'

RSpec.describe 'the pet_apps new page' do
  before(:each) do
    visit '/apps/new'
  end

  #Story 3
  # As a visitor
  # When I visit the new application page
  # And I fail to fill in any of the form fields
  # And I click submit
  # Then I am taken back to the new applications page
  # And I see a message that I must fill in those fields.
  it 'requires all of the fields filed out before submitting' do
    fill_in 'Name', with: 'Alex'
    fill_in 'City', with: 'Houston'
    fill_in 'Street', with: '123 fake' 
    click_button 'commit'
    #expect errors
    expect(page).to have_content("Error: Zip can't be blank, Zip is not a number, State can't be blank")
    fill_in 'zip', with: '80204'
    fill_in 'State', with: 'MI'
    click_button 'commit'
    #fill in missing fields, submit returns 
  end
end