require 'rails_helper'

RSpec.describe 'Start Application' do
  it 'links to a new page to start application' do
    visit '/pets'
    click_link('Start an Application')

    expect(current_path).to eq('/applications/new')
  end

  it 'can create a new application' do
    visit '/applications/new'

    fill_in('First Name', with: 'Kelly')
    fill_in('Middle Name (optional)', with: 'Sarah')
    fill_in('Last Name', with: 'Johnson')
    fill_in('Street Number', with: 4928)
    fill_in('Street Prefix (if any)', with: 'N')
    fill_in('Street Name', with: 'Main')
    fill_in('Street Type', with: 'Avenue')
    fill_in('City', with: 'Arvada')
    fill_in('State', with: 'Colorado')
    fill_in('Zip Code', with: 83020)
    fill_in("Why would you make a good forever home?", with: 'I have a large backyard')
    click_button("Submit")

    ksj_application = Application.last

    name = "#{ksj_application.first_name} #{ksj_application.middle_name} #{ksj_application.last_name}"
    address = "#{ksj_application.street_number} #{ksj_application.street_prefix} #{ksj_application.street_name} #{ksj_application.street_type}"
    city = "#{ksj_application.city}"
    state = "#{ksj_application.state}"
    zip = "#{ksj_application.zip_code}"
    ksj_why = "#{ksj_application.description}"

    expect(current_path).to eq("/applications/#{ksj_application.id}")
    expect(page).to have_content(name)
    expect(page).to have_content(address)
    expect(page).to have_content(city)
    expect(page).to have_content(state)
    expect(page).to have_content(zip)
    expect(page).to have_content(ksj_why)
    expect(page).to have_content('In Progress')
  end

  it 'returns to new application form when form is not completed' do
    visit '/applications/new'

    fill_in('First Name', with: 'Kelly')
    fill_in('Last Name', with: 'Johnson')
    fill_in('Street Number', with: 4928)
    fill_in('Street Prefix (if any)', with: 'N')
    fill_in('Street Name', with: 'Main')
    fill_in('City', with: 'Arvada')
    fill_in('State', with: 'Colorado')
    click_button("Submit")

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content('Please fill out necessary fields for submission')
    expect(page).to have_button("Submit")
  end
end
