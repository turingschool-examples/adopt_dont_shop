require 'rails_helper'

RSpec.describe 'applications new page' do 
  it 'has a link to start an application' do
    visit ("/pets")

    click_link("Start an Application")
    expect(current_path).to eq("/applications/new")
  end
  
  it 'takes me to new application page' do
    visit "/applications/new"

    fill_in :name, with: 'Helen'
    fill_in :street_address, with: "555 Blueberry Run"
    fill_in :city, with: 'Charleston'
    fill_in :state, with: 'West Virginia'
    fill_in :zip_code, with: '25301'

    click_button 'Submit'

    expect(current_path).to eq("/applications/#{Application.last.id}")

    expect(page).to have_content("Helen")
    expect(page).to have_content("555 Blueberry Run")
    expect(page).to have_content("In Progress")
  end
end
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:

# And I click submit
# Then I am taken to the new applicatio
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress