require 'rails_helper'

RSpec.describe 'the application index' do
  before(:each) do
    @pet_application = PetApplication.create!(name: 'Kathy', street_address: '16998 Farmwell Drive', city: 'Denver', state: 'Colorado', zip_code: '80014', description: 'No kids', status: 'Pending')
  end

  it 'show a link to start an application' do
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
    visit "/pets"
    click_link("Start an Application")
    expect(current_path).to eq("/pet_applications/new/")
    fill_in 'Applicant', with: "Kathy"
    fill_in 'Street Address', with: "16998 Farmwell Drive"
    fill_in 'City', with: "Denver"
    fill_in 'State', with: "Colorado"
    fill_in 'Zip Code', with: "80014"
    fill_in 'Description', with: "No kids"
    fill_in 'Application Status', with: "Pending"
    click_on("Save")
    save_and_open_page
    expect(current_path).to eq("/pet_applications/#{@pet_application.id}/")
  end
end
