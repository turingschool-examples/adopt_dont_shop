require 'rails_helper'

RSpec.describe 'the application show' do
  let!(:shelter) {Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:app_1) {Application.create(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303, description: 'I need to combat loneliness' )}
  let!(:app_2) {Application.create(name: 'Jenn', street_address: '2 Wildflower Lane', city: 'Aurora', state: 'CO', zip_code: 80010, description: 'I need fluffy pets to cuddle' )}
  let!(:pet_1) {Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
  let!(:pet_2) {Pet.create!(name: "Zucchini", breed: 'weenie dog', age: 7, adoptable: true, shelter_id: shelter.id)}

  let!(:pet_application_1) {PetApplication.create(pet_id: pet_2.id, application_id: app_1.id)}
  # let!(:pet_application_2) {PetApplication.create(pet_id: pet_1.id, application_id: app_2.id)}

  it "shows the application and all it's attributes" do
    visit "/applications/#{app_1.id}"

    expect(page).to have_content('Stephen')
    expect(page).to have_content('3 Green St')
    expect(page).to have_content('Boulder')
    expect(page).to have_content('CO')
    expect(page).to have_content(80303)
    expect(page).to have_content('I need to combat loneliness')
    expect(page).to have_content('In Progress')
    expect(page).to_not have_content('Jenn')
    expect(page).to have_link('Zucchini')
    click_link 'Zucchini'
    expect(current_path).to eq("/pets/#{pet_2.id}")

  end

  it "allows you to add a pet to the application if the application has not been submitted" do
    visit "/applications/#{app_1.id}"
    expect(page).to have_content('In Progress')
    expect(page).to have_content('Add a Pet to this Application')

    fill_in("Search by name", with: "Lucille Bald")
    click_button "Search"

    expect(current_path).to eq("/applications/#{app_1.id}")
    within "#pet-#{pet_1.id}" do
      expect(page).to have_content('Lucille Bald')
    end
  end
end
