require 'rails_helper'

RSpec.describe 'the new application page' do 
  it 'displays a fillable form' do 
    visit '/applications/new' 
    save_and_open_page

    expect(page).to have_selector(:css, 'form')
    expect(page).to have_content('New Application')
    expect(page).to have_content('Name')
    expect(page).to have_content('Reason for adoption')
    expect(page).to have_content('In Progress')
    expect(page).to have_content('Street')
    expect(page).to have_content('City')
    expect(page).to have_content('State')
    expect(page).to have_content('Zipcode')

    expect(page).to have_button('Submit')
  end
end