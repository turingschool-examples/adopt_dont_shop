require 'rails_helper'

RSpec.describe "Creating a new Application" do
  it "when i visit the pets index page theres a link for a new application" do
    visit "/pets"
    expect(page).to have_link("Start An Application")
    click_link "Start an Application"

    expect(current_path).to eq("/applications/new")

    fill_in "name", with: "Scott"
    fill_in "address", with: "237 Nope St"
    fill_in "city", with: "No Way"
    fill_in "state", with: "USA"
    fill_in "zip_code", with: 12345

    click_button "submit"

    visit "/applications/#{application.id}"

    expect(page).to have_content("Scott")
    expect(page).to have_content("237 Nope St")
    expect(page).to have_content("No Way")
    expect(page).to have_content("USA")
    expect(page).to have_content(12345)
  end

  it "Shows for not Completed Error Message" do
    visit "/applications/new"

    fill_in "name", with: ""
    fill_in "address", with: "237 Nope St"
    fill_in "city", with: "No Way"
    fill_in "state", with: "USA"
    fill_in "zip_code", with: 12345

    click_button "submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("237 Nope St")
    expect(page).to have_content("No Way")
    expect(page).to have_content("USA")
    expect(page).to have_content(12345)
    expect(page).to have_content("Please fill out all fields")
  end

end
