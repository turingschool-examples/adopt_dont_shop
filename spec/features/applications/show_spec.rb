require 'rails_helper'

RSpec.describe 'the applications show page' do
  let!(:shelter){Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:pet_1){Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
  let!(:pet_2){Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)}

  it "shows the applications and all it's attributes" do
    application = pet_1.applications.create(name: 'Frank', street_address: '123 Main St', city: 'Long Beach', state: 'CA', zipcode: '90712', description: 'I have a fully fenced in acre property', status: 'pending')
    AdoptablePet.create!(application: application, pet: pet_2)
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    find_link("#{pet_1.name}")
    find_link("#{pet_2.name}")
  end

  it "Has a section to add a pet to the application and search for a pet" do
    application = Application.create!(name: 'Frank', street_address: '123 Main St', city: 'Long Beach', state: 'CA', zipcode: '90712', description: 'I have a fully fenced in acre property', status: 'In Progress')

    visit "/applications/#{application.id}"
    expect(page).to have_content("Add a Pet to this Application")
    fill_in('search_by_name', with: "Lobster")
    click_on("Submit")
    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Lobster")
  end
end
