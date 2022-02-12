require 'rails_helper'

RSpec.describe 'adding a new application' do
  it 'creates a new application' do
    visit '/applications/new'

    fill_in("Name", with: "Jelly Boy")
    fill_in('Street Address', with: "234 Smart Guy Ln.")
    fill_in('City', with: "Tuscaloosa")
    fill_in('State', with: "ID")
    fill_in('Zip Code', with: "86753")
    fill_in('Tell us why you would be a good home for one of our pets', with: "Because I am Jelly Boy!")

    click_button('Submit')

    id = Application.last.id
save_and_open_page
    expect(current_path).to eq("/applications/#{id}")

    expect(page).to have_content("Jelly Boy")
    expect(page).to have_content("234 Smart Guy Ln.")
    expect(page).to have_content("Tuscaloosa")
    expect(page).to have_content("ID")
    expect(page).to have_content("86753")
    expect(page).to have_content("Because I am Jelly Boy!")
    expect(page).to have_content("In Progress")
  end
end
