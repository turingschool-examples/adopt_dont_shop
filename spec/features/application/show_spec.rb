require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    application = Application.create!(
      name: "John",
      address: "123 clarkson ln.",
      applicant_qualitys: "Loves dogs",
      pet_names: "Sparky",
      application_status: "In Progress")

    visit "applications/#{application.id}"

    expect(page).to have_content("John")
    expect(page).to have_content("123 clarkson ln.")
    expect(page).to have_content("Loves dogs")
    expect(page).to have_content("Sparky")
    expect(page).to have_content("In Progress")
  end
end

