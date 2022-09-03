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
      @jimmy_application = Application.create!(      name: "Jimmy John",       street_address: "303 Broadway",       city: "Denver",       state: "CO",       zip_code: 80122,       description: "I would love to have a companion",       status: "In Progress")
      @shelter = Shelter.create!(      foster_program: true,       name: "Sara's Safehouse",       city: "Inglewood",       rank: 3)
      @fido = Pet.create!(      adoptable: true,       age: 3,       breed: "dog",       name: "Fido",       shelter_id: @shelter.id)
      @purrs = Pet.create!(      adoptable: true,       age: 10,       breed: "cat",       name: "Purrs",       shelter_id: @shelter.id)
      PetApplication.create!(      application: @jimmy_application,       pet: @fido)
      PetApplication.create!(      application: @jimmy_application,       pet: @purrs)
    end

    it("shows the attributes of the applicant") do
      visit("/applications/#{@jimmy_application.id}")
      expect(current_path).to(eq("/applications/#{@jimmy_application.id}"))
      expect(page).to(have_content(@jimmy_application.name))
      expect(page).to(have_content(@jimmy_application.street_address))
      expect(page).to(have_content(@jimmy_application.city))
      expect(page).to(have_content(@jimmy_application.state))
      expect(page).to(have_content(@jimmy_application.zip_code))
    end

    it("names all pets that this application is for with links to the pets show page") do
      visit("/applications/#{@jimmy_application.id}")
      click_on("#{@fido.name} show page")
      expect(page).to(have_content("Fido"))
      expect(current_path).to(eq("/pets/#{@fido.id}"))
      visit("/applications/#{@jimmy_application.id}")
      click_on("#{@purrs.name} show page")
      expect(page).to(have_content("Purrs"))
      expect(current_path).to(eq("/pets/#{@purrs.id}"))
    end

    it("shows the application status as either \"In Progress\", \"Pending\", \"Accepted\", or \"Rejected\"") do
      visit("/applications/#{@jimmy_application.id}")
      expect(page).to(have_content(@jimmy_application.status))
    end

    describe("Story 5") do
      describe("wehn I go the application show page and that app has not been submitted") do
        it("I see a section to Add a Pet to this Application") do
          visit("/applications/#{@jimmy_application.id}")
          expect(current_path).to(eq("/applications/#{@jimmy_application.id}"))
          expect(page).to(have_content("Add a Pet to this Application"))
        end

        it("can search for pets by name and route back to the application show page") do
          @baldy = Pet.create!(          adoptable: true,           age: 9,           breed: "cat",           name: "Baldy",           shelter_id: @shelter.id)
          visit("/applications/#{@jimmy_application.id}")
          fill_in("pet_name",           with: "Baldy")
          expect(page).to(have_button("Search"))
          click_button("Search")
          expect(current_path).to(eq("/applications/#{@jimmy_application.id}"))
          expect(page).to(have_content("Baldy"))
          expect(page).to_not(have_content("Shouldnt be here"))
        end
      end
    end

    describe("Story 6") do
      it("can see a button to adopt the pet after searching by name and to add to adoptable pets") do
        @baldy = Pet.create!(        adoptable: true,         age: 9,         breed: "cat",         name: "Baldy",         shelter_id: @shelter.id)
        visit("/applications/#{@jimmy_application.id}")
        fill_in("pet_name",         with: "Baldy")
        expect(page).to(have_button("Search"))
        click_button("Search")
        expect(page).to(have_button("Adopt"))
        click_button("Adopt")
        expect(current_path).to(eq("/applications/#{@jimmy_application.id}"))
      end
    end

    describe("story 7") do
      it("And in that section I see an input to enter why I would make a good owner for these pet(s)") do
        visit("/applications/#{@jimmy_application.id}")
        fill_in("description",         :with => "this is the description")
        click_button("Submit my application")
        expect(current_path).to(eq("/applications/#{@jimmy_application.id}"))
        expect(page).to(have_content("Pending"))
        expect(page).not_to(have_content("Add a Pet to this Application"))
      end
    end
  end
end
