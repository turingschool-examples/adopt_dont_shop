require 'rails_helper'

describe 'applications show page', type: :feature do
  let!(:application) {Application.create!(name: 'Jasmine', street_address: '1011 P St.', city: 'Las Vegas', state: 'Nevada', zip_code: '89178', description: "I'm lonely.", status: 'Pending')}
  let!(:application2) {Application.create!(name: 'Elle', street_address: '2023 Something St.', city: 'Denver', state: 'Colorado', zip_code: '80014', description: "I love animals!", status: 'In Progress')}

  let!(:pet1) {application.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
  let!(:pet2) {application.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)}

  let!(:shelter) {Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}

  describe 'user story 1' do
    it 'shows applicant name, address, description, application pets, and application status' do
      visit "applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to_not have_content(application2.name)
      expect(page).to have_content("#{application.street_address} #{application.city}, #{application.state} #{application.zip_code}")
      expect(page).to have_content(application.description)
      expect(page).to have_content(pet1.name)
      expect(page).to have_content(pet2.name)
      expect(page).to have_content(application.status)
    end

    it 'has a link to the show page of each pet listed in the application' do
      visit "applications/#{application.id}"

      expect(page).to have_link(pet1.name)
      expect(page).to have_link(pet2.name)

      click_link "#{pet1.name}"

      expect(current_path).to eq("/pets/#{pet1.id}")
    end
  end

  describe 'user story 4' do
    it "has a section to search for a pet on an 'In Progress' application" do
      visit "applications/#{application2.id}"

      expect(page).to have_content("In Progress")
      expect(page).to_not have_content("#{pet2.name}")

      within "#application-add-pets" do
        expect(page).to have_content("Add a Pet to this Application")
        
        fill_in 'search', with: 'Lobster'
        click_on "Submit"

        expect(current_path).to eq("/applications/#{application2.id}")
        expect(page).to have_content("#{pet2.name}")
        expect(page).to have_content("#{pet2.age} years old")
        expect(page).to have_content("Breed: #{pet2.breed}")
        expect(page).to have_content("Adoptable? #{pet2.adoptable}")
        expect(page).to have_content("At #{pet2.shelter_name}")
      end
    end
  end

  describe 'user story 5' do
    it "has a link to add a pet to an 'In Progress' application" do
      visit "applications/#{application2.id}"
    
      fill_in 'search', with: 'Lobster'
      click_on "Submit"

      expect(page).to have_link("Adopt this Pet")
      
      click_link "Adopt this Pet"

      expect(current_path).to eq("/applications/#{application2.id}")

      within '#application-pets' do
        expect(page).to have_content("#{pet2.name}")
      end
    end
  end
end