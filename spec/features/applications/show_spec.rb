require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  before(:each) do
    visit "/applications/#{@app_1.id}"
  end

  it 'has a application header' do
    expect(page).to have_content("Application")
  end

  it 'shows the application information' do
    expect(page).to have_content("Name: #{@app_1.name}")
    expect(page).to have_content("Street Address: #{@app_1.street_address}")
    expect(page).to have_content("City: #{@app_1.city}")
    expect(page).to have_content("State: #{@app_1.state}")
    expect(page).to have_content("Zip Code: #{@app_1.zip_code}")
    expect(page).to have_content("Reason: #{@app_1.reason}")
    expect(page).to have_content("Status: #{@app_1.status}")
  end

  it 'it can search for pets for the application' do
    expect(page).to have_content("Add a Pet to this Application")

    fill_in("Search pets", with: "The")
    click_button("Search Pets")
    expect(current_path).to eq("/applications/#{@app_1.id}")

    expect(page).to have_content("Jabba The Butt")
    expect(page).to have_content("The Other Dude")
    expect(page).to_not have_content("The Great Catsby")
    expect(page).to_not have_content("Tango Mango")
    expect(page).to_not have_content("Cheesebro")
  end

  it 'can add a pet to the application' do
    expect(page).to have_content("Add a Pet to this Application")

    fill_in("Search pets", with: "Cheese")
    click_button("Search Pets")

    expect(current_path).to eq("/applications/#{@app_1.id}")
    expect(page).to have_button("Adopt this Pet")

    click_button("Adopt this Pet")
    expect(current_path).to eq("/applications/#{@app_1.id}")
    expect(page).to have_link("Cheesebro")

    click_on("Cheesebro")
    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end
end