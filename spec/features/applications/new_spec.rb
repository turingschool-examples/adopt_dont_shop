require 'rails_helper'

describe "Application new page" do
  it 'has a link on the pet index page that takes you to the new application page' do
    visit '/pets'

    click_link('Start an Application')

    expect(current_path).to eq('/applications/new')
  end

  it 'has a form to create a new application and a default status of in progress' do
    visit '/pets'

    click_link('Start an Application')
    expect(current_path).to eq('/applications/new')

    fill_in('Name', with: 'Devin Pile')
    fill_in('Address', with: 'Easy St')
    fill_in('City', with: 'Parker')
    fill_in('State', with: 'Colorado')
    fill_in('Zip', with: '80911')

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Devin Pile")
    expect(page).to have_content("Easy St")
    expect(page).to have_content("Parker")
    expect(page).to have_content("In Progress")
  end

  it 'takes you back to the new application field with messages to complete fields if all fields not filled in' do
    visit '/applications/new'

    fill_in('Name', with: 'Devin Pile')
    fill_in('City', with: 'Parker')
    fill_in('State', with: 'Colorado')
    fill_in('Zip', with: '8091')
    click_button('Submit')

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content("Error")
    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("Zip is the wrong length")
  end
end