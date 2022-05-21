require 'rails_helper'

RSpec.describe ApplicationForm, type: :feature do
  describe "application create page" do
    it "renders the new form" do
      # As a visitor
      # When I visit the pet index page
      # Then I see a link to "Start an Application"
      # When I click this link
      # Then I am taken to the new application page where I see a form
      # When I fill in this form with my:
      #   - Name
      #   - Street Address
      #   - City
      #   - State
      #   - Zip Code
      # And I click submit
      # Then I am taken to the new application's show page
      # And I see my Name, address information, and description of why I would make a good home
      # And I see an indicator that this application is "In Progress"

      shelter_1 = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 5)
      shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: true, rank: 9)

      pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
      pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
      pet_3 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_2.id)

      # applicationform_1 = ApplicationForm.create(name: "Hank", street_address: "1234 Some Street", city: "Aurora", state: "CO", zip_code: "80015", description: "I'd like an animal please", status: "In Progress")
      # applicationform_2 = ApplicationForm.create(name: "Levi", street_address: "4321 Another Street", city: "Los Angeles", state: "CA", zip_code: "12345", description: "wanna animal", status: "Pending")
      # applicationform_3 = ApplicationForm.create(name: "Diana", street_address: "4444 Oneother Court", city: "Detroit", state: "MI", zip_code: "54321", description: "I love animals", status: "Accepted")
      # applicationform_4 = ApplicationForm.create(name: "Michael", street_address: "621311 Thisdude Street", city: "Philadelphia", state: "PA", zip_code: "19147", description: "Definitely NOT for fighting", status: "Rejected")

      # application_pets_1 = ApplicationPet.create(pet: pet_1, application_form: applicationform_1)
      # application_pets_2 = ApplicationPet.create(pet: pet_3, application_form: applicationform_2)
      # application_pets_3 = ApplicationPet.create(pet: pet_1, application_form: applicationform_2)

      visit "/pets/"
      # save_and_open_page
      click_link "Start an Application"
      expect(current_path).to eq('/application_forms/new')

      expect(page).to have_content('New Application')
      fill_in 'Name', with: 'Hank'
      fill_in 'Street Address', with: '1234 Some Street'
      fill_in 'City', with: 'Aurora'
      fill_in 'State', with: 'CO'
      fill_in 'Zip Code', with: '80015'

      click_button "Submit"

      expect(current_path).to eq("/application_forms/#{applicationform_2.id}/")
      #not sure about this path

        expect(page).to have_content('Hank')
        expect(page).to have_content('1234 Some Street')
        expect(page).to have_content('Aurora')
        expect(page).to have_content('CO')
        expect(page).to have_content('80015')
        expect(page).to have_content('Description:')
        expect(page).to have_content('Status: In Progress')








    end
  end
end
