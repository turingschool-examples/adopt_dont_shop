require 'rails_helper'

RSpec.describe 'the application create' do
  it 'can create a new application' do

    visit "/pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '90210'

    click_button "Submit"
    
    expect(page).to have_content('Jimbo Jones')
    expect(page).to have_content('123 Fake St Denver CO 90210')
    expect(page).to have_content('In Progress')
  end

  it 'returns an error if application is not complete' do
    visit "/pets"

    click_link "Start an Application"
    
    fill_in 'Name', with: 'Jimbo Jones'
    fill_in 'Street', with: '123 Fake St'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'

    click_button "Submit"
    
    expect(page).to have_content("Error: Zip code can't be blank")
  end
end
# Add a Pet to an Application

# As a visitor
# When I visit an application's show page
# And I search for a Pet by name
# And I see the names Pets that match my search
# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application