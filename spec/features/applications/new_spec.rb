require 'rails_helper'

RSpec.describe 'new application page', type: :feature do
  before(:each) do
    visit "/applications/new"
  end

  it 'has a application header' do
    expect(page).to have_content("New Application")
  end

  it 'can create a new application' do
    fill_in('Name', with: 'Samuel Xander')
    fill_in('Street address', with: '749 Bank Street')
    fill_in('City', with: 'Oxford')
    fill_in('State', with: 'MS')
    fill_in('Zip code', with: '38655')
    fill_in('Reason', with: 'Im lonely')
    page.select('Pending', from: 'Status').click
    click_button('Create Application')
    new_app = Application.find_by(name: "Samuel Xander")

    expect(current_path).to eq("/applications/#{new_app.id}")
    expect(page).to have_content('Samuel Xander')
  end
end