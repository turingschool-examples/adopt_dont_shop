require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  before(:each) do
    visit "/applications/#{@app_2.id}"
  end

  it 'has a application header' do
    expect(page).to have_content("Application")
  end

  it 'shows the application information' do
    
    expect(page).to have_content("Name: #{@app_2.name}")
    expect(page).to have_content("Street Address: #{@app_2.street_address}")
    expect(page).to have_content("City: #{@app_2.city}")
    expect(page).to have_content("State: #{@app_2.state}")
    expect(page).to have_content("Zip Code: #{@app_2.zip_code}")
    expect(page).to have_content("Reason: #{@app_2.reason}")
    expect(page).to have_content("Status: #{@app_2.status}")
  end
end