require 'rails_helper'

RSpec.describe 'the new application page' do
  it 'new application form with default status : in progress' do
    visit "/applications/new"

    fill_in(:name, with: "Asil Rolyat")
    fill_in(:street_address, with: "76 Park Ave" )
    fill_in(:city, with: "Denver" )
    fill_in(:state, with: "CO")
    fill_in(:zipcode, with: "80111")
    fill_in(:description, with: "I love cats!")

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
end
