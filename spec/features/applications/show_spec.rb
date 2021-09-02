require 'rails_helper'

RSpec.describe 'the applications show' do
  it "shows the application and all it's attributes" do
    application = Application.create!(name: "Kevin Mugele", street_address: "694 Glen Road", city: "Sparta", state: "New Jersey", zip_code: 90210, status: "Open", statement: "I am looking to give a dog their forever home")

    visit "/applications/#{application.id}"

    expect(page).to have_content("Current Application")
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.statement)
  end
end
