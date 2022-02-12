require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all its attributes" do
    application = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
      status: "In Progress"
    )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  xit "shows the pets that the application is for and links to their show page" do
    application = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      status: "In Progress"
    )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.status)
  end


end
