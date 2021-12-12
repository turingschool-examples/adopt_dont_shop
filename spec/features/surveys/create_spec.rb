require 'rails_helper'

RSpec.describe 'survey creation page' do
  let!(:survey_1) {Survey.create!(
    name: "John Napier", 
    street_address: "936 Akin Ave.", 
    city: "Fort Collins", 
    state: "CO.", 
    zip_code: 80521, 
    description: "Good Owner", 
    status: "Pending")}

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

    fill_in :name, with: 'John'
    fill_in :street_address, with: '2309 Stanford Rd.'
    fill_in :city, with: 'Fort Collins'
    fill_in :state, with: 'Colorado'
    fill_in :zip_code, with: '80525'

    click_button 'Submit'
    
    expect(current_path).to eq("/surveys/#{Survey.last.id}")
save_and_open_page
  end
end