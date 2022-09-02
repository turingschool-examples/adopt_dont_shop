# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
require "rails_helper"


RSpec.describe("Applications show page") do
  describe("When I visit an applications show page Then I can see the following:") do
    before(:each) do
      @jimmy_application = Application.create!(      name: "Jimmy John",       street_address: "303 Broadway",       city: "Denver",       state: "CO",       zip_code: 80122,       description: "I would love to have a companion",       status: "Pending")
      @shelter = Shelter.create!(      foster_program: true,       name: "Sara's Safehouse",       city: "Inglewood",       rank: 3)
      @fido = Pet.create!(      adoptable: true,       age: 3,       breed: "dog",       name: "Fido",       shelter_id: @shelter.id)
      @purrs = Pet.create!(      adoptable: true,       age: 10,       breed: "cat",       name: "Purrs",       shelter_id: @shelter.id)
      PetApplication.create!(      application: @jimmy_application,       pet: @fido)
      PetApplication.create!(      application: @jimmy_application,       pet: @purrs)
    end

    it("shows the attributes of the applicant shows the description of why the applicant says the would be a good home") do
      visit("/applications/#{@jimmy_application.id}")

      expect(current_path).to(eq("/applications/#{@jimmy_application.id}"))
      expect(page).to(have_content(@jimmy_application.name))
      expect(page).to(have_content(@jimmy_application.street_address))
      expect(page).to(have_content(@jimmy_application.city))
      expect(page).to(have_content(@jimmy_application.state))
      expect(page).to(have_content(@jimmy_application.zip_code))
      expect(page).to(have_content(@jimmy_application.description))
    end

    it 'names all pets that this application is for with links to the pets show page' do

      visit "/applications/#{@jimmy_application.id}"

      click_on("#{@fido.name} show page")
      expect(page).to have_content("Fido")
      expect(current_path).to eq("/pets/#{@fido.id}")

      visit "/applications/#{@jimmy_application.id}"

      click_on("#{@purrs.name} show page")
      expect(page).to have_content("Purrs")
      expect(current_path).to eq("/pets/#{@purrs.id}")
    end

    it 'shows the application status as either "In Progress", "Pending", "Accepted", or "Rejected"' do

      visit "/applications/#{@jimmy_application.id}"

      expect(page).to have_content(@jimmy_application.status)
    end

    it 'Story 5, if the application has not been submitted/in progress, then i will see a section where i can search for pets by name ' do

      visit "/applications/#{@jimmy_application.id}"

      fill_in "Search", with: "Spot"
      click_on "Search"

      expect(current_path).to eq("/applications/#{@jimmy_application.id}")
      expect(page).to have_content("Fido")
      expect(page).to_not have_content("Frenchie")
    end

  end
end
