require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    application = Application.create!(name: 'Bobby Lully', address: '123 Sesame Street, Denver, CO 12345', description: "I need a friend", pets: "Scooby", status: "Pending")

    visit "/#{application.id}"

    expect(page).to have_content(application.pets)
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end
end
