require 'rails_helper'

RSpec.describe 'create new application page' do
  it 'has form to create new application' do

    visit "/pets"
    save_and_open_page
    click_link('Start an Application')
    expect(current_path).to eq("/applications/new")

    fill_in('Name', with: 'Matt Holmes')
    fill_in('Address', with: '123')
    fill_in('Street', with: 'Pwahoo Ln')
    fill_in('City', with: 'Arvada')
    fill_in('State', with: 'CO')
    fill_in('Zip Code', with: '80214')

    click_button('Submit')


    expect(current_path).to eq("/application/:id")
    expect(page).to have_content('Matt Holmes')
  end

end
#
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
