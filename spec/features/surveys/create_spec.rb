require 'rails_helper'

RSpec.describe 'survey creation page' do
  it 'renders the new form' do 
    visit "/surveys/new" 

    expect(page).to have_content("New Application")
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip Code')
  end

  it 'submits the application' do 
    visit "/surveys/new"

    fill_in 'Name', with: 'John'
    fill_in 'Street Address', with: '2309 Stanford Rd.'
    fill_in 'City', with: 'Fort Collins'
    fill_in 'State', with: 'Colorado'
    fill_in 'Zip Code', with: '80525'

    click_button 'Submit'

    expect(current_path).to eq("/survey/#{Survey.last.id}")
  end
end