require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    application = Application.create(
      name: 'Joseph Puglia',
      address: '5201 Whistle St., Irvine CA. 92602',
      description: 'Has lots of money',
      pets: 'localhost:3000/pets/1, localhost:3000/pets/2',
      status: 'Pending'
    )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.pets)
    expect(page).to have_content(application.status)
  end
end