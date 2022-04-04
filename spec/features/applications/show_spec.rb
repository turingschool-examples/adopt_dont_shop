require "rails_helper"

RSpec.describe "the application show" do
  let!(:smith_app) { Application.create!(name: "Bobby Smith", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "Im Awesome!", app_status: "Rejected") }

  it "shows the application and all it's attributes" do
    visit "/applications/#{smith_app.id}"

    expect(page).to have_content(smith_app.name)
    expect(page).to have_content(smith_app.address)
    expect(page).to have_content(smith_app.city)
    expect(page).to have_content(smith_app.state)
    expect(page).to have_content(smith_app.zipcode)
    expect(page).to have_content(smith_app.description)
    expect(page).to have_content(smith_app.app_status)
    expect(page).to have_content("Pets applied for:")
  end

  it "has 'Add Pet' section" do
    visit "/applications/#{smith_app.id}"

    expect(page).to have_content("Add a pet to this application")
  end
end
