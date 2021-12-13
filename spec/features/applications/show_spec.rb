require 'rails_helper'

RSpec.describe 'Application show page' do
  it 'can display the attributes of an applicant' do
        shelter = Shelter.create!(name: "Dumb Friends League", city: "Aurora", foster_program: true, rank: 7)
        brooke = Application.create!(
                name: "Brooke Hoffmann",
                street_address: "448 N Montgomery St",
                city: "Aurora",
                state: "CO",
                zip_code: 80014,
                description: "I'm an experienced pet owner"
                  )
        rob = Application.create!(
                name: "Rob Griswold",
                street_address: "1234 Dogwood Ct",
                city: "Denver",
                state: "CO",
                zip_code: 80124,
                description: "I love all animals",
                status: "Accepted"
                  )
        pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
        pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
        pet_3 = Pet.create!(adoptable: true, age: 5, breed: 'husky', name: 'Zippy', shelter_id: shelter.id)

        PetApplication.create!(application_id: brooke.id, pet_id: pet_1.id)
        PetApplication.create!(application_id: brooke.id, pet_id: pet_2.id)
        PetApplication.create!(application_id: rob.id, pet_id: pet_3.id)
    visit "/applications/#{brooke.id}"

    expect(page).to have_content("Name: Brooke Hoffmann")
    expect(page).to have_content("Address: 448 N Montgomery St")
    expect(page).to have_content("Aurora")
    expect(page).to have_content("CO")
    expect(page).to have_content(80014)
    expect(page).to have_content("Applicant description: I'm an experienced pet owner")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content(rob.name)
    expect(page).to_not have_content(rob.street_address)
    expect(page).to_not have_content(rob.city)
    expect(page).to_not have_content(rob.zip_code)
    expect(page).to_not have_content(rob.description)
    expect(page).to_not have_content(pet_3.name)
    expect(page).to_not have_content("Accepted")
  end

  it 'has a section on the page to add a pet to the application' do
    brooke = Application.create!(
            name: "Brooke Hoffmann",
            street_address: "448 N Montgomery St",
            city: "Aurora",
            state: "CO",
            zip_code: 80014,
            description: "I'm an experienced pet owner"
              )
    visit "/applications/#{brooke.id}"
    # And that application has not been submitted,
    expect(page).to have_content("Add a pet to this application")
  end

  it 'can search for a pet' do
    shelter = Shelter.create!(name: "Dumb Friends League", city: "Aurora", foster_program: true, rank: 7)

    brooke = Application.create!(
            name: "Brooke Hoffmann",
            street_address: "448 N Montgomery St",
            city: "Aurora",
            state: "CO",
            zip_code: 80014,
            description: "I'm an experienced pet owner"
              )

    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: true, age: 5, breed: 'husky', name: 'Zippy', shelter_id: shelter.id)

    visit "/applications/#{brooke.id}"

    fill_in 'search', with: 'Lucille Bald'
    click_on("Search")

    expect(current_path).to eq("/applications/#{brooke.id}")
    expect(page).to have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)

    fill_in 'search', with: "Lobster"
    click_on("Search")

    expect(current_path).to eq("/applications/#{brooke.id}")
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_3.name)

    fill_in 'search', with: "Zippy"
    click_on("Search")

    expect(current_path).to eq("/applications/#{brooke.id}")
    expect(page).to have_content(pet_3.name)
    expect(page).to_not have_content(pet_1.name)
    expect(page).to_not have_content(pet_2.name)
  end

  it 'has a button to add a pet to the application' do
    shelter = Shelter.create!(name: "Dumb Friends League", city: "Aurora", foster_program: true, rank: 7)

    brooke = Application.create!(
            name: "Brooke Hoffmann",
            street_address: "448 N Montgomery St",
            city: "Aurora",
            state: "CO",
            zip_code: 80014,
            description: "I'm an experienced pet owner"
              )

    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: true, age: 5, breed: 'husky', name: 'Zippy', shelter_id: shelter.id)

    PetApplication.create!(application_id: brooke.id, pet_id: pet_1.id)

    visit "/applications/#{brooke.id}"

    fill_in 'search', with: 'Lucille Bald'
    click_on("Search")

    expect(current_path).to eq("/applications/#{brooke.id}")
    expect(page).to have_button("Adopt this Pet")

    click_on("Adopt this Pet")

    expect(current_path).to eq("/applications/#{brooke.id}")
    expect(page).to have_content('Lucille Bald')
  end
end

# As a visitor
# When I visit an application's show page
# And I search for a Pet by name

# Then next to each Pet's name I see a button to "Adopt this Pet"
# When I click one of these buttons
# Then I am taken back to the application show page
# And I see the Pet I want to adopt listed on this application
