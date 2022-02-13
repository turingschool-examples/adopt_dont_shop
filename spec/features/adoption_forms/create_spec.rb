require 'rails_helper'

describe 'application / adoption form' do
  it 'has a link to the application from the pet index' do
    visit '/pets'

    click_link "Start an Application"

    expect(current_path).to eq(new_adoption_form_path)
  end

  it 'has fields for applicant info' do
    visit new_adoption_form_path

    expect(page).to have_field("First name")
    expect(page).to have_field("Last name")
    expect(page).to have_field("Street address")
    expect(page).to have_field("City")
    expect(page).to have_field("State")
    expect(page).to have_field("Zip code")
    expect(page).to have_field("Describe your home")
  end

  it 'creates a new application when click submit' do
    visit new_adoption_form_path

    fill_in "First name", with: "Joe"
    fill_in "Last name", with: "Average"
    fill_in "Street address", with: "356 Willow Creek"
    fill_in "City", with: "Evergreen"
    fill_in "State", with: "CO"
    fill_in "Zip code", with: "80457"
    fill_in "Describe your home", with: "Spacious, smoke free, pet free"
    click_button "Save"

    joe = AdoptionForm.last

    expect(current_path).to eq("/adoption_forms/#{joe.id}")

    expect(page).to have_content(joe.first_name)
    expect(page).to have_content(joe.last_name)
    expect(page).to have_content(joe.street_address)
    expect(page).to have_content(joe.zip_code)
    expect(page).to have_content(joe.city)
    expect(page).to have_content(joe.state)
    expect(page).to have_content(joe.description)
  end

  it 'Displays an error when form is incomplete' do
    visit new_adoption_form_path

    fill_in "First name", with: "Joe"
    fill_in "Last name", with: "Average"
    fill_in "Street address", with: "356 Willow Creek"
    fill_in "City", with: "Evergreen"
    fill_in "Describe your home", with: "Spacious, smoke free, pet free"

    click_button "Save"

    expect(page).to have_current_path(new_adoption_form_path)
    expect(page).to have_content("Error: State can't be blank, Zip code can't be blank")
  end
end
