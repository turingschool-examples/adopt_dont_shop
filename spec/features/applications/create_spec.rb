require 'rails_helper'

RSpec.describe 'create a new application', type: :feature do

  it 'has a page with an applicaiton form' do
    visit("/applications/new")

    expect(find('form')).to have_content "Name"
    expect(find('form')).to have_content "Street Address"
    expect(find('form')).to have_content "City"
    expect(find('form')).to have_content "State"
    expect(find('form')).to have_content "Zip Code"
    expect(find('form')).to have_button "Submit"
  end

  it 'can create a new application upon submit' do 
    visit("/applications/new")

    fill_in("Name", with: "John Doe")
    fill_in(:street_address, with: "654 Main St.")
    fill_in("City", with: "Birmingham")
    fill_in("State", with: "AL")
    fill_in("Zip Code", with: "98798")

    click_button("Submit")

    expect(Application.last.name).to eq("John Doe")
    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("John Doe")
    expect(page).to have_content("654 Main St.")
    expect(page).to have_content("Birmingham")
    expect(page).to have_content("AL")
    expect(page).to have_content("98798")
    expect(page).to have_content("Application Status: In Progress")
  end

  it 'redirects to the new application page with an error displayed' do
    visit("/applications/new")
    fill_in("Name", with: "John Doe")
    fill_in(:street_address, with: "654 Main St.")
    fill_in("City", with: "Birmingham")
    fill_in("State", with: "AL")
    click_button("Submit")

    expect(Application.last).to be nil
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application not Submitted. Please fill out all fields.")
  end

end