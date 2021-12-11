require 'rails_helper'

# Starting an Application
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
RSpec.describe 'New Application' do

  it 'links to the new page from the pets index' do

    visit '/pets'
    expect(page).to have_link("Start an Application")
    click_link("Start an Application")

    expect(current_path).to eq('/applications/new')
  end

  it 'can create a new application' do

    visit '/applications/new'

    fill_in('Name', with: 'Kerri Hoffmann')
    fill_in('street_address', with: '1234 N Mongomery St')
    fill_in('City', with: 'Aurora')
    fill_in('State', with: "CO")
    fill_in("zip_code", with: 80014)
    fill_in("Description", with: "I love all animals")

    click_on("Submit Application")
    new_application_id = Application.last.id
    expect(current_path).to eq("/applications/#{new_application_id}")
    expect(page).to have_content("Kerri Hoffmann")
  end

  it 'can instruct a user to fill out the form completely' do
    visit '/applications/new'

    fill_in('Name', with: "")
    fill_in('street_address', with: '1234 N Mongomery St')
    fill_in('City', with: 'Aurora')
    fill_in('State', with: "CO")
    fill_in("zip_code", with: 80014)
    fill_in("Description", with: "I love all animals")

    click_on("Submit Application")

    expect(page).to have_content("Please fill form out completely")
    expect(current_path).to eq('/applications/new')
  end
end

# Starting an Application, Form not Completed
#
# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.
