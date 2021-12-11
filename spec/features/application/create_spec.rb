require 'rails_helper'

RSpec.describe 'application creation' do
  before do
    @application = Application.create!(name:'Name1', address: '123 test st', city: 'Bear', state: 'Delaware', zip: '19701', description: "this is a description" )

  end

  it "creates new application" do
    visit '/applications/new'
    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip')
    expect(find('form')).to have_content('Description')
    expect(page).to have_button('Submit')

  end

  it 'creates the application and redirects to the applications show page' do

    visit '/applications/new'
    fill_in 'Name', with: 'Name1'
    fill_in 'Address', with: '123 test st'
    fill_in 'City', with: 'Bear'
    fill_in 'State', with: 'Delaware'
    fill_in 'Zip', with: '19701'
    fill_in 'Description', with: "this is a description"
    click_button 'Submit'
    application = Application.find_by(name:'Name1')
    expect(page).to have_current_path("/applications/#{application.id}")
    expect(page).to have_content('Name1')
    expect(page).to have_content('123 test st')
    expect(page).to have_content('Bear')
    expect(page).to have_content('Delaware')
    expect(page).to have_content('19701')
    expect(page).to have_content("this is a description")
  end
end
