require 'rails_helper'

RSpec.describe 'Applications New' do
  it 'provides a link to start an application' do
    visit "/applications/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Street Address")
  end

  it 'accepts user information and returns them to application show page' do
    visit "/applications/new"

    fill_in :name, with: 'Chaz Simons'
    fill_in :street_address, with: '1234 Cool Guy Rd'
    fill_in :city, with: 'Las Vegas'
    fill_in :state, with: 'NV'
    fill_in :zip_code, with: 89106

    click_button "Submit"

    expect(page).to have_content("Chaz Simons")
  end
end
