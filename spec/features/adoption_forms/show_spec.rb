require 'rails_helper'

describe 'Pet adoption application show page', type: :feature do
  before do
    @form = create(:adoption_form)
    visit adoption_form_path(@form)
  end

  it 'displays all details of the pet application' do
    expect(page).to have_content("Application Info")
    expect(page).to have_content("First name: #{@form.first_name}")
    expect(page).to have_content("Last name: #{@form.last_name}")
    expect(page).to have_content("Street address: #{@form.street_address}")
    expect(page).to have_content("City: #{@form.city}")
    expect(page).to have_content("State: #{@form.state}")
    expect(page).to have_content("Zip code: #{@form.zip_code}")
    expect(page).to have_content("Description of home: #{@form.description}")
    expect(page).to have_content("Application status: #{@form.status}")
  end

  it 'has a search bar for pets' do
    pet = create(:pet, name: "Fluffy")
    expect(page).not_to have_content(pet.name)

    fill_in :search, with: "flu"
    click_on "Search"

    expect(page).to have_content(pet.name)
  end

  it 'adds a pet to that application' do
    fluffy = create(:pet, name: "Fluffy")

    fill_in :search, with: "flu"
    click_on "Search"

    within "#pet_#{fluffy.id}" do
      click_button("Adopt this pet")
    end
    expect(current_path). to eq(adoption_form_path(@form))
    expect(page).to have_content("Pets on this application:\n#{fluffy.name}")
    expect(@form.pets).to eq([fluffy])
  end
end
