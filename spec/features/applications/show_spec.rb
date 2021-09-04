require 'rails_helper'

RSpec.describe 'the app show page' do
  it 'shows an applicants personal info' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    app_1 = Application.create!(name: "Cindy Lou Who", address: "123 Some Street", city: "Chicago", state: "IL", zip: "12345", description: "I'm a who for crying out loud.")

    app_pet_1 = ApplicationPet.create!(pet: pet_1, application: app_1)

    visit "/applications/#{app_1.id}"
save_and_open_page
    expect(page).to have_content("Applicant Name: Cindy Lou Who")
    expect(page).to have_content("Address: 123 Some Street, Chicago, IL 12345")
    expect(page).to have_content("Description: I'm a who for crying out loud.")
    expect(page).to have_content("Pet(s) Applying For: #{pet_1.name}")
    expect(page).to have_content("Application Status: In Progress")

    # test link to pet_1
  end
end
