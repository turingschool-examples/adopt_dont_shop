require 'rails_helper'

RSpec.describe 'new application page' do
  it 'creates a new application' do
    visit '/applications/new'

    fill_in("Name", with: "Frodo Baggins")
    fill_in("Street Address", with: "1 Shire Ave")
    fill_in("City", with: "Las Vegas")
    fill_in("State", with: "NV")
    fill_in("Zipcode", with: "88901")

    click_on("Submit")
    new_app = Application.last
    expect(current_path).to eq("/applications/#{new_app.id}")

    expect(page).to have_content("Frodo Baggins")
    expect(page).to have_content("1 Shire Ave")
    expect(page).to have_content("Las Vegas")
    expect(page).to have_content("NV")
    expect(page).to have_content("88901")
    expect(page).to have_content("N/A")
    expect(page).to have_content("In Progress")
    expect(page).not_to have_content("Accepted")
  end

  it 'tells you when the form is not fully completed' do
    visit '/applications/new'

    fill_in("Name", with: "Frodo Baggins")
    fill_in("Street Address", with: "1 Shire Ave")
    fill_in("State", with: "NV")
    fill_in("Zipcode", with: "88901")

    click_on("Submit")
    expect(page).to have_content("Error: City can't be blank")
    expect(current_path).to eq("/applications/new")
  
  end
end
