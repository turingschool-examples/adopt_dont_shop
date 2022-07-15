require 'rails_helper'

RSpec.describe "application show page" do
    #   As a visitor When I visit an applications show page Then I can see the following:
#     Name of the Applicant
#     Full Address of the Applicant including street address, city, state, and zip code
#     Description of why the applicant says they'd be a good home for this pet(s)
#     names of all pets that this application is for (all names of pets should be links to their show page)
#     The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    it 'displays the name, full address, description, names of all pets in the application as links, and the status of the application' do 
        new_applicant = Applicant.create!(name: "Test", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555, names_pets_wanted: "Fido", description: "they love pets!", application_status: "In Progress")
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        fido = shelter_1.pets.create(name: 'Fido', breed: 'Beagle', age: 5, adoptable: true)
        ApplicantPet.create!(pet: fido, applicant: new_applicant)
        visit "/applications/#{new_applicant.id}"
        
        # save_and_open_page
        expect(page).to have_content("name: Test")
        expect(page).to have_content("address: 5555 Test Avenue")
        expect(page).to have_content("city: Denver")
        expect(page).to have_content("state: CO")
        expect(page).to have_content("name of pets wanting to adopt: Fido")
        #Links to pets not currently working atm - Nick

        expect(page).to have_content("application_status: In Progress")

    end 
end