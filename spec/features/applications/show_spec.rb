require 'rails_helper'

RSpec.describe 'application show' do

  it 'contains the name, address, bio, list of pets, and the application status for given application' do

    application_1 = Application.create!(
      first_name: "Alex",
      last_name: "Boyd",
      street_address: "123 Sesame Street",
      city: "Washington",
      state: "District of Columbia",
      applicant_bio: "Hey lemme have that cat or else",
      application_status: "Pending"
    )
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)


    ApplicationPet.create!(application: application_1, pet: pet_1)
    ApplicationPet.create!(application: application_1, pet: pet_2)
    ApplicationPet.create!(application: application_1, pet: pet_3)

    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.first_name)
    expect(page).to have_content(application_1.last_name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.applicant_bio)
    
    within '#pet-1' do
      expect(page).to have_content(pet_1.name)
      click_link "#{pet_1.name}"
      expect(current_path).to eq("/pets/#{pet_1.id}")
    end
    
    visit "/applications/#{application_1.id}"

    within '#pet-2' do      
      expect(page).to have_content(pet_2.name)
      click_link "#{pet_2.name}"
      expect(current_path).to eq("/pets/#{pet_2.id}")
    end

    visit "/applications/#{application_1.id}"

    within '#pet-3' do      
      expect(page).to have_content(pet_3.name)
      click_link "#{pet_3.name}"
      expect(current_path).to eq("/pets/#{pet_3.id}")
    end

  end

end