require 'rails_helper'

RSpec.describe 'the applications index' do
  it "shows a list of all the applicants" do
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210, status: "Open", statement: "I am looking to give a dog their forever home")

    visit "/applications"

    expect(page).to have_content("All Applications")
    expect(page).to have_content(application.name)
  end

  it "has a link to a specific application" do
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210, status: "Open", statement: "I am looking to give a dog their forever home")

    visit "/applications"
    click_on "Kevin Mugele"

    expect(current_path).to eq("/applications/#{application.id}")
  end
end
