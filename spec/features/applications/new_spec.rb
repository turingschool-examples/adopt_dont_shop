require 'rails_helper'


RSpec.describe 'new application page' do

  it 'can fill out the application form' do
    visit '/application/new'

    fill_in :name, with: 'Billy'
    fill_in :address, with: '1234 3rd ave'
    fill_in :city, with: 'Denver'
    fill_in :state, with: 'Colorado'
    fill_in :zip, with: 12345

    click_button 'submit'

    expect(Application.count).to eq(1)

    app = Application.last

    expect(current_path).to eq("/applications/#{app.id}")
    expect(page).to have_content(app.name)
    expect(page).to have_content(app.street_address)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zip)
    expect(page).to have_content('In progress')
  end


end
