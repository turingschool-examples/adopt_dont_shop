require 'rails_helper'

RSpec.describe 'application show page' do
  let!(:application_1) { Application.create!(name: 'Bob', street_address: '1234 Southeast St',
                                            city: 'San Francisco', state: 'CA', zip_code: 12345,
                                            description: 'Wants a dog', name_of_pet: 'Lobster', application_status: "In Progress") }

  let!(:application_2) { Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
                                            city: 'San Francisco', state: 'CA', zip_code: 54321,
                                            description: 'Would like a siamese cat', name_of_pet: 'Lucille Bald', application_status: "In Progress") }

  let!(:application_3) { Application.create!(name: 'Fred', street_address: '376 Monroe St',
                                            city: 'Los Angeles', state: 'CA', zip_code: 67890,
                                            description: 'Interested in sibling pets', name_of_pet: 'Beethoven', application_status: "In Progress") }


    it 'displays application information' do
      visit "/applications/#{application_1.id}"
      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zip_code)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.name_of_pet)
      expect(page).to have_content(application_1.application_status)
    end

    it 'can search for pet name to add to application' do
      
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter: shelter_1)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter: shelter_2)
      pet_3 = Pet.create!(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter: shelter_3)

      visit "/applications/#{application_1.id}"

      expect(page).to have_content("In Progress")
      expect(page).to have_content("Add a Pet to this Application")

      fill_in(:pet_search, with: 'Lobster')
      click_button('Search Pet')

      expect(current_path).to eq("/applications/#{application_1.id}")
    end
end