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
    expect(page).to have_selector("input[type=submit]")
  end

  it 'successfully creates a new application and redirects to application show page' do
    visit "/applications/new"

    fill_in "name", with: "Jim bob"
    fill_in "street_address", with: "1234 happytown lane"
    fill_in "city", with: "who cares"
    fill_in "state", with: "Alabama"
    fill_in "zip_code", with: "14920"
    find("input[type=submit]").click
    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Jim bob")
  end

  it 'gives you an error and refreshes the page when you dont fill in a required field' do
    visit "/applications/new"
    fill_in "name", with: "Jim bob"
    fill_in "street_address", with: "1234 happytown lane"
    fill_in "city", with: "who cares"
    fill_in "zip_code", with: "14920"
    find("input[type=submit]").click
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application Not Created, Required Information Missing")
  end
end
