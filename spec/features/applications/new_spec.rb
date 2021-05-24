require 'rails_helper'

RSpec.describe 'Applications New Page' do
  it 'has a form to fill out an application' do
    visit '/applications/new'

    expect(page).to have_content('Name')
    expect(page).to have_content('Street Address')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Zip Code')

    fill_in 'Name', with: 'Roald'
    fill_in 'Street Address', with: '6415 Allison St.'
    fill_in 'City', with: 'Westminster'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip Code', with: 80003

    click_on('Submit Application')

    expect(page).to have_content('Roald')
    expect(page).to have_content('6415 Allison St.')
    expect(page).to have_content('Westminster')
    expect(page).to have_content('Colorado')
    expect(page).to have_content(80003)
    expect(current_path).to eq("/applications/#{Application.all.last[:id]}")
  end
end
