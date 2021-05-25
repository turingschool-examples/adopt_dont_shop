require 'rails_helper'

RSpec.describe 'application new page' do
  it 'can go to the new application page' do
    visit '/applications/new'

    expect(current_path).to eq('/applications/new')
  end

  it 'has a form in the new application page' do
    visit 'applications/new'

    expect(page).to have_css('#name')
    expect(page).to have_css('#street_address')
    expect(page).to have_css('#city')
    expect(page).to have_css('#state')
    expect(page).to have_css('#zip_code')
    expect(page).to have_css('#description')
    expect(page).to have_button('Submit')
  end

  it 'can redirect the user to the show page for the new application' do
    visit 'applications/new'

    fill_in('Name', with: 'Jessica Smith')
    fill_in('Street Address', with: '356 Main St')
    fill_in('City', with: 'Smyrna')
    fill_in('State', with: 'Georgia')
    fill_in('Zip Code', with: '30346')
    fill_in('Description', with: 'I will love this pet forever!')

    click_button('Submit')
    @new_application = Application.last
    expect(current_path).to eq("/applications/#{@new_application.id}")
  end

  it 'shows the new application as in progress by default' do
    visit 'applications/new'

    fill_in('Name', with: 'Jessica Smith')
    fill_in('Street Address', with: '356 Main St')
    fill_in('City', with: 'Smyrna')
    fill_in('State', with: 'Georgia')
    fill_in('Zip Code', with: '30346')
    fill_in('Description', with: 'I will love this pet forever!')

    click_button('Submit')
    @new_application = Application.last

    visit "/applications/#{@new_application.id}"

    expect(page).to have_content("#{@new_application.status}")
    expect(@new_application.status).to eq("In Progress")
  end

  it 'redirects the user to the new application page if the form is not completed' do
    visit "/applications/new"

    fill_in('Name', with: 'Jessica Smith')
    fill_in('Street Address', with: '356 Main St')
    fill_in('City', with: 'Smyrna')
    fill_in('State', with: 'Georgia')
    fill_in('Zip Code', with: '30346')
    click_button('Submit')

    expect(current_path).to eq("/applications/new")
  end

  it 'displays a message that the user must fill in missing fields before submitting' do
    visit "/applications/new"

    fill_in('Name', with: 'Jessica Smith')
    fill_in('Street Address', with: '356 Main St')
    fill_in('City', with: 'Smyrna')
    fill_in('State', with: 'Georgia')
    fill_in('Zip Code', with: '30346')
    click_button('Submit')

    expect(page).to have_content("Please fill in missing fields.")
    # ask if the fields need to be specified or if this general statement is okay
  end
  
end
