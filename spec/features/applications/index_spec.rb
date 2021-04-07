require 'rails_helper'

RSpec.describe 'the applications index page' do
  it 'expect page to have all applications 'do

    @joan = Application.create(name: "Joan", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801, status: "Pending", description: "I am depressed")
    @parker = Application.create(name: "Parker", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801, status: "Pending", description: "cat")
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    visit '/applications'

    expect(page).to have_content(@joan.name)
    expect(page).to have_content(@joan.address)
    expect(page).to have_content(@joan.city)
    expect(page).to have_content(@joan.state)
    expect(page).to have_content(@joan.zip_code)
    expect(page).to have_content(@joan.status)
    expect(page).to have_content(@joan.description)
    expect(page).to have_content(@parker.name)
    expect(page).to have_content(@parker.address)
    expect(page).to_not have_content(@shelter.name)
  end
end
