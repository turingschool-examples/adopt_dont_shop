require 'rails_helper'

RSpec.describe 'the applications new page' do
  it 'can fill in forms' do
    visit '/applications/new'

    fill_in('Name', with: 'Sylvester Tommy')

    fill_in(:street_address, with: '1827 Vincent Ave')

    fill_in('City', with: 'Denver')

    fill_in('State', with: 'Colorado')

    fill_in(:zip_code, with: '38271')

    fill_in('Description', with: 'I LOVE pets')

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")

    expect(page).to have_content('Sylvester Tommy')

    expect(page).to have_content('1827 Vincent Ave')

    expect(page).to have_content('Denver')

    expect(page).to have_content('Colorado')

    expect(page).to have_content('38271')

    expect(page).to have_content('I LOVE pets')

    expect(page).to have_content('In Progress')
  end

  it 'checks to make sure that all the fields are populated' do
    visit '/applications/new'

    expect(page).to_not have_content('Please fill in all the fields')

    fill_in('Name', with: 'Sylvester Tommy')
    fill_in(:street_address, with: '1827 Vincent Ave')
    fill_in('City', with: 'Denver')

    click_button('Submit')

    expect(current_path).to eq('/applications/new')

    expect(page).to have_content('Please fill in all the fields')
  end
end
