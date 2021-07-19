require 'rails_helper'

RSpec.describe 'applications' do
  before(:each) do
    @application = Application.create!(name: 'Jason Knoll',
                                      street_address: '1234 N. Something St',
                                      city: "Scottsdale",
                                      state: "AZ",
                                      zip_code: "99999",
                                      description: "I love pets",
                                      status: "In Progress")
  end

  # When I visit the pet index page
  # Then I see a link to "Start an Application"
  # When I click this link
  # Then I am taken to the new application page where I see a form
  # When I fill in this form with my:
  #
  # Name
  # Street Address
  # City
  # State
  # Zip Code
  # And I click submit
  # Then I am taken to the new application's show page
  # And I see my Name, address information, and description of why I would make a good home
  # And I see an indicator that this application is "In Progress"

  it 'can gives all options for new applicant' do
    visit "/applications/new"
    save_and_open_page

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip Code')

    click_button "Submit"
  end

  it 'can create a new applicant' do
    visit "/applications/new"

    fill_in "Name", with: "Megan"
    fill_in "Street Address", with: "5678 W. second St."
    fill_in "City", with: "Dallas"
    fill_in "State", with: "TX"
    fill_in "Zip Code", with: "88888"

    click_button "Submit"

    expect(current_path).to_not eq("/applications/new")
    expect(page).to have_content("Megan")
    expect(page).to have_content("5678 W. second St.")
    expect(page).to have_content("Dallas")
    expect(page).to have_content("TX")
    expect(page).to have_content("88888")
    expect(page).to have_content("In Progress")
  end
end
