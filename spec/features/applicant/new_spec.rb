require 'rails_helper'

RSpec.describe 'new application page', type: :feature do 

  it 'US25: can create and submit a new application' do
    visit '/applicants/new'
    
    fill_in 'Name', with: 'Oliver Smudger'
    fill_in 'Street address', with: '1234 N Random Avenue'
    fill_in 'City', with: 'Tucson'
    fill_in 'State', with: 'Arizona'
    fill_in 'Zip code', with: '12345'

    expect(page).to have_button('Submit')
    click_button('Submit')     

    expect(page).to have_content('Oliver Smudger')
    expect(page).to have_content('1234 N Random Avenue')
    expect(page).to have_content('Tucson')
    expect(page).to have_content('Arizona')
    expect(page).to have_content('12345')
    expect(page).to have_content('In Progress')
  end

  it 'US24: must have all the form fields filled in' do 
    visit '/applicants/new'

    fill_in 'Name', with: 'Oliver Smudger'
    fill_in 'Street address', with: ''
    fill_in 'City', with: 'Tucson'
    fill_in 'State', with: 'Arizona'
    fill_in 'Zip code', with: '12345'

    expect(page).to have_button('Submit')
    click_button('Submit') 

    expect(current_path).to eq('/applicants/new')
    expect(page).to have_content("Error: Street address can't be blank")
  end
end
