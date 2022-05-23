require 'rails_helper'

describe 'the application show', type: :feature do
  let!(:shelter) {Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:app_1) {Application.create(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)}
  let!(:app_2) {Application.create(name: 'Jenn', street_address: '2 Wildflower Lane', city: 'Aurora', state: 'CO', zip_code: 80010)}
  let!(:pet_1) {Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
  let!(:pet_2) {Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter.id)}
  let!(:pet_application_1) {PetApplication.create(pet_id: pet_2.id, application_id: app_1.id)}

  it "shows the application's attributes" do
    visit "/applications/#{app_1.id}"

    within "#application-display" do
      expect(page).to have_content('Stephen')
      expect(page).to have_content('3 Green St')
      expect(page).to have_content('Boulder')
      expect(page).to have_content('CO')
      expect(page).to have_content(80303)
      expect(page).to have_content('In Progress')
      expect(page).to_not have_content('Jenn')
      expect(page).to have_link('Zucchini')

      click_link 'Zucchini'
    end

    expect(current_path).to eq("/pets/#{pet_2.id}")
  end

  it "if application is 'In Progress', it has a form to search for pet by name and can find match" do
    visit "/applications/#{app_1.id}"

    expect(page).to have_content('In Progress')
    expect(page).to have_content('Add a Pet to this Application')

    fill_in("Search by name", with: "Lucille Bald")
    click_button "Search"

    expect(current_path).to eq("/applications/#{app_1.id}")

    within "#matching-pets" do
      expect(page).to have_content('Lucille Bald')
      expect(page).to_not have_content('Zucchini')
    end
  end

  it "can search for pet by name and find a partial match" do
    visit "/applications/#{app_1.id}"

    fill_in("Search by name", with: "ucille")
    click_button "Search"

    within "#matching-pets" do
      expect(page).to have_content('Lucille Bald')
      expect(page).to_not have_content('Zucchini')
    end
  end

  it "can search for pet by name case insensitively" do
    visit "/applications/#{app_1.id}"

    fill_in("Search by name", with: "lucille bald")
    click_button "Search"

    within "#matching-pets" do
      expect(page).to have_content('Lucille Bald')
      expect(page).to_not have_content('Zucchini')
    end
  end

  it "can add a pet to the application" do
    visit "/applications/#{app_1.id}"

    fill_in("Search by name", with: "Zucchini")
    click_button "Search"

    within "#matching-pets" do
      expect(page).to have_content('Zucchini')
      click_button "Adopt this pet"
      expect(current_path).to eq("/applications/#{app_1.id}")
    end

    within "#application-display" do
      expect(page).to have_link("Zucchini")
    end
  end

  it "can submit an application if pets are added" do
    visit "/applications/#{app_2.id}"

    expect(page).to_not have_button("Submit Application")

    visit "/applications/#{app_1.id}"

    expect(page).to have_link('Zucchini')
    expect(page).to have_button("Submit Application")

    fill_in("description", with: "I need to combat loneliness")
    click_button("Submit Application")

    expect(current_path).to eq("/applications/#{app_1.id}")
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("In Progress")
    expect(page).to_not have_content("Add a Pet to this Application:")

  end
end
