require 'rails_helper'

RSpec.describe 'can create and fill out applications' do
  it 'can fill in and submit applications' do
    visit '/applications/new'

    fill_in 'first_name', with: 'Bobby'
    fill_in 'last_name', with: 'Otter'
    fill_in 'street_address', with: '123 Oyster haven'
    fill_in 'city', with: 'Clamville'
    fill_in 'state', with: 'Colorado'
    fill_in 'zip_code', with: '12332'
    fill_in 'application_status', with: 'In progress'

    click_button 'Submit Application'

    expect(page).to have_content('Bobby')
    expect(page).to have_content('Otter')
    expect(page).to have_content('123 Oyster haven')
    expect(page).to have_content('Clamville')
    expect(page).to have_content('Colorado')
    expect(page).to have_content('12332')
    #expect(page).to have_content('In progress')
    #expect(current_path).to eq("/application")
  end
end
