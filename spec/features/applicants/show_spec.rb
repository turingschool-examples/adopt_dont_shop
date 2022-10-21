require 'rails_helper'

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
RSpec.describe 'applications show page' do 
    before (:each) do
        @applicant1 = Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", good_fit: "I am a Judgy Motha", status: "Rejected")
        @applicant2 = Applicant.create!(name: "Pink Flyod", street_address: "5150 High St", city: "Crater Lake", state: "None", zip: "12345", good_fit: "I need a companion", status: "Accepted")
    end
    it 'has the attributes of the applicant' do 
      
        visit "/applicants/#{@applicant1.id}"

        expect(page).to have_content(@applicant1.name)
        expect(page).to have_content(@applicant1.street_address)
        expect(page).to have_content(@applicant1.city)
        expect(page).to have_content(@applicant1.status)
        expect(page).to_not have_content(@applicant2.name)
    end

    it 'lists and links the pets for this application' do 
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        pet1 = shelter_1.pets.create!(adoptable: true, age: 4, breed: "Rotweiller", name: "Raider")
        pet2 = shelter_1.pets.create!(adoptable: true, age: 99, breed: "Chihuahua", name: "Yoda")

        @applicant1.pets << pet1 << pet2
        #pet1.applicants << applicant1 
        #pet2.applicants << applicant1
        #PetApplicants.create!(pet: pet2, shelter: shelter_1)
        visit "applicants/#{@applicant1.id}"
        
        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet2.name)

        save_and_open_page
        click_link("Raider")
        expect(current_path).to eq("/pets/#{pet1.id}")
    end
end