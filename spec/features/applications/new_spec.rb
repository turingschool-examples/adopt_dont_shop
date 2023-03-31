require 'rails_helper'

RSpec.describe 'Application creation', type: :feature do
  it 'links the new application page' do
    visit "/pets"

    click_link 'Start an Application'
    expect(current_path).to eq('/applications/new')
  end

  it 'takes you to the new applications show page after filling out the form' do
    visit "/applications/new"

    fill_in('name', with: 'Bostan')
    fill_in('street_address', with: 'Arden Dr.')
    fill_in('city', with: 'Winder')
    fill_in('state', with: 'GA')
    fill_in('zip_code', with: 523)
    fill_in('description', with: 'Me like animal')
    
    click_button('Submit')
    @application = Application.last
    expect(current_path).to eq("/applications/#{@application.id}")

    expect(page).to have_content("#{@application.name}")
    expect(page).to have_content("#{@application.street_address}")
    expect(page).to have_content("#{@application.city}")
    expect(page).to have_content("#{@application.state}")
    expect(page).to have_content("#{@application.zip_code}")
    expect(page).to have_content("#{@application.description}")
  end
end
