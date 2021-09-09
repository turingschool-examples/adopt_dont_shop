require 'rails_helper'

RSpec.describe 'application#creation' do
  it 'has a link on the pet index page that takes you to the new application page' do
    visit '/pets'

    click_link('New Application Here')

    expect(current_path).to eq('/applications/new')
  end

  it 'has a form to create a new application and a default status of in progress' do
    visit '/pets'

    click_link('New Application Here')
    expect(current_path).to eq('/applications/new')

    fill_in('Name', with: 'Taylor Swift')
    fill_in('Street address', with: '500 W Main')
    fill_in('City', with: 'Louisville')
    fill_in('State', with: 'KY')
    fill_in('Zip code', with: '40205')

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Taylor Swift")
    expect(page).to have_content("500 W Main")
    expect(page).to have_content("Louisville")
    expect(page).to have_content("In Progress")
  end
end
