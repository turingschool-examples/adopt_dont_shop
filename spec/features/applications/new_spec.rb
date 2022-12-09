require 'rails_helper'

RSpec.describe 'new application page' do
  it 'has a form with the relevant fields' do
    visit "/applications/new"

    expect(page).to have_content("Start New Application")
    expect(page).to have_field("name")
    expect(page).to have_field("street_address")
    expect(page).to have_field("city")
    expect(page).to have_field("state")
    expect(page).to have_field("zip_code")
    expect(page).to have_field("description")
    expect(page).to have_selector("input[type=submit]")
  end

end