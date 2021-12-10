require 'rails_helper'

RSpec.describe 'New Application Form' do

  it 'links from the pets index page' do

  visit '/pets'
  click_link("Start an Application")
  expect(current_path).to eq('/applications/new')
  end

  xit 'can create a new application' do
    visit '/applications/new'

    fill_in('Name', with: 'Kerri Hoffmann')
    fill_in('street_address', with: '1234 N Mongomery St')
    fill_in('City', with: 'Aurora')
    fill_in('State', with: "CO")
    fill_in("zip_code", with: 80014)
    fill_in("Description", with: "I love all animals")

    click_button("Submit Application")

    expect(current_path).to eq("/applications/#{application.id}")
  end
end
