require 'rails_helper'

RSpec.describe 'applications' do
  before(:each) do
    @application = Application.create!(name: 'Jason Knoll',
                                      street_address: '1234 N. Something St',
                                      city: "Scottsdale",
                                      state: "AZ",
                                      zip_code: "99999")
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

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip Code')

    click_button "Submit"
  end

  describe 'the applicant create' do
    context 'given valid data' do
      it 'can create a new applicant' do
        visit "/applications/new"

        fill_in "Name", with: "Megan"
        fill_in "Street Address", with: "5678 W. second St."
        fill_in "City", with: "Dallas"
        fill_in "State", with: "TX"
        fill_in "Zip Code", with: "88888"

        click_button "Submit"
        application = Application.last

        expect(current_path).to eq("/applications/#{application.id}")
        expect(page).to have_content("Megan")
        expect(page).to have_content("5678 W. second St.")
        expect(page).to have_content("Dallas")
        expect(page).to have_content("TX")
        expect(page).to have_content("88888")
        expect(page).to have_content("In Progress")
      end
    end

    context 'given invalid data' do
      it 'must have all fields correctly filled' do
        # Starting an Application, Form not Completed
        #
        # As a visitor
        # When I visit the new application page
        # And I fail to fill in any of the form fields
        # And I click submit
        # Then I am taken back to the new applications page
        # And I see a message that I must fill in those fields.

        visit "/applications/new"

        fill_in "Name", with: "Megan"
        fill_in "Street Address", with: "5678 W. second St."

        click_button "Submit"
        save_and_open_page

        expect(current_path).to eq("/applications/new")
        expect(page).to have_content("Error: City can't be blank, Zip code can't be blank, Zip code is not a number")
      end
    end
  end
end
