require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @application_1 = Application.create!(name: "Holden Caulfield", street_address: "123 Main St", city: "New York", state: "NY", zipcode: 12345, description: "I wouldn't be a good pet owner", status: "Pending")
  end

  describe 'new application' do
    it 'renders the new form' do
      visit "/pets"
      click_link('Start an Application')

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
    end
  end

  it 'new application form with default status : in progress' do
    visit "/applications/new"

    fill_in(:name, with: "Asil Rolyat")
    fill_in(:street_address, with: "76 Park Ave" )
    fill_in(:city, with: "Denver" )
    fill_in(:state, with: "CO")
    fill_in(:zipcode, with: 80111)

    click_button("Submit")

    application = Application.last

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content("In Progress")
  end

  it 'given invalid data - re-renders new form' do
    visit "/applications/new"

    fill_in(:name, with: "Asil Rolyat")
    fill_in(:city, with: "Denver" )
    fill_in(:state, with: "CO")
    fill_in(:zipcode, with: "a80111")

    click_button("Submit")

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error: Street address can't be blank, Zipcode is not a number")
  end
end
