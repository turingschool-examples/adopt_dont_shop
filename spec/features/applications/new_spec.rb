require 'rails_helper'

RSpec.describe 'New Application' do 
  it 'Creates a new application form' do 
    # visit "/pets"

    # click_link "Start an Application"
    visit '/applications/new'
    expect(current_path).to eq("/applications/new")

    fill_in('name', with: 'Shaggy')
    fill_in('street', with: '544 Mystery Machine Lane')
    fill_in('city', with: 'Los Angeles')
    fill_in('state', with: 'CA')
    fill_in('zip_code', with: '90210')
    click_on('Submit')

    new_application_id = Application.last.id
    expect(current_path).to eq("/applications/#{new_application_id}")
    expect(page).to have_content('Shaggy')
  end 
end 