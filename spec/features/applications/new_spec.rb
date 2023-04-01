require 'rails_helper'

RSpec.describe 'new applicatiom' do
  it 'displays fields' do
    visit '/applications/new'
    expect(page).to have_content("Name")
    expect(page).to have_content("Address")
    expect(page).to have_content("City")
    expect(page).to have_content("State")
    expect(page).to have_content("Zip")
    expect(page).to have_content("Why would you make a good home?")
    expect(page).to have_button("Save")
  end

  it 'shows error and redirects with missing field' do
    visit '/applications/new'
    fill_in 'Name', with: 'Jon'
    fill_in 'Address', with: '1234 Street'
    fill_in 'City', with: 'Super City'
    fill_in 'State', with: 'Tx'
    fill_in 'description', with: "Because"
    click_button 'Save'
    expect(page).to have_current_path("/applications/new")
    expect(page).to have_content("Error: Zip can't be blank")
  end

  it 'saves when completed and goes to show page' do
    visit '/applications/new'
    fill_in 'Name', with: 'Jon'
    fill_in 'Address', with: '1234 Street'
    fill_in 'City', with: 'Super City'
    fill_in 'State', with: 'Tx'
    fill_in 'Zip', with: '12345'
    fill_in 'description', with: "Because"
    click_button 'Save'
    
    expect(page).to have_content("Jon")
    expect(page).to have_content("In Progress")
  end
end