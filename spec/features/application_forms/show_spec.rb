require 'rails_helper'

RSpec.describe ApplicationForm, type: :feature do
  describe "application show page" do
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    it "Shows all the info of an application form and provides links to each pet for that application form" do
      shelter_1 = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 5)
      shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: true, rank: 9)

      pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
      pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
      pet_3 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_2.id)

      applicationform_1 = ApplicationForm.create(name: "Hank", street_address: "1234 Some Street", city: "Aurora", state: "CO", zip_code: "80015", description: "I'd like an animal please", status: "In Progress")
      applicationform_2 = ApplicationForm.create(name: "Levi", street_address: "4321 Another Street", city: "Los Angeles", state: "CA", zip_code: "12345", description: "wanna animal", status: "Pending")
      applicationform_3 = ApplicationForm.create(name: "Diana", street_address: "4444 Oneother Court", city: "Detroit", state: "MI", zip_code: "54321", description: "I love animals", status: "Accepted")
      applicationform_4 = ApplicationForm.create(name: "Michael", street_address: "621311 Thisdude Street", city: "Philadelphia", state: "PA", zip_code: "19147", description: "Definitely NOT for fighting", status: "Rejected")

      application_pets_1 = ApplicationPet.create(pet: pet_1, application_form: applicationform_1)
      application_pets_2 = ApplicationPet.create(pet: pet_3, application_form: applicationform_2)
      application_pets_3 = ApplicationPet.create(pet: pet_1, application_form: applicationform_2)

      visit "/application_forms/#{applicationform_2.id}/"

      expect(page).to have_content(applicationform_2.name)
      expect(page).to have_content(applicationform_2.street_address)
      expect(page).to have_content(applicationform_2.city)
      expect(page).to have_content(applicationform_2.state)
      expect(page).to have_content(applicationform_2.zip_code)
      expect(page).to have_content(applicationform_2.description)
      save_and_open_page
      applicationform_2.pets.each do |pet|
        expect(page).to have_content(pet.name)
        click_link pet.name
        expect(current_path).to eq("/pets/#{pet.id}/")
        visit "/application_forms/#{applicationform_2.id}/"
      end

      expect(current_path).to eq("/application_forms/#{applicationform_2.id}/")
      expect(page).to have_content(applicationform_2.status)
    end
  end
end
