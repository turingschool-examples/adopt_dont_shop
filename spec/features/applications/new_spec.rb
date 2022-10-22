require "rails_helper"


RSpec.describe("Application new Page") do
  before(:each) do
    @smithers_application = Application.create!(    name: "Smithers",     street_address: "99 Higgins Estate",     city: "Springfield",     state: "IL",     zip_code: 90597,     description: "I have a lot of land and no friends",     status: "In Progress")
    @homer_application = Application.create!(    name: "Homer",     street_address: "24 East Ridge",     city: "Springfield",     state: "IL",     zip_code: 90597,     description: "since the drinking hole closed i have a lot of time on my hands and no friends",     status: "In Progress")
    @shelter = Shelter.create(    name: "Mystery Building",     city: "Irvine CA",     foster_program: false,     rank: 9)
    @scooby = Pet.create(    name: "Scooby",     age: 2,     breed: "Great Dane",     adoptable: true,     shelter_id: @shelter.id)
    @bolt = Pet.create(    name: "Bolt",     age: 1,     breed: "Chihuahua",     adoptable: true,     shelter_id: @shelter.id)
    @pet_app_1 = PetApplication.create!(    pet: @bolt,     application: @smithers_application)
  end

  describe("Correct workflow test") do
    describe("#3.visit the new application page") do
      describe("I fill in the form fields") do
        describe("I click submit Then I am taken to the new applications Show page") do
          it("#3.I see those fields complete.") do
            visit("/applications/new")
            expect(page).to(have_content("New Application"))
            fill_in("Name",             with: "Dom")
            fill_in("Street Address",             with: "722 E Kensington Rd")
            fill_in("City",             with: "Los Angeles")
            fill_in("State",             with: "CA")
            fill_in("Zipcode",             with: 90026)
            click_button("Submit")
            @new_app = Application.all.last
            expect(current_path).to(eq("/applications/#{@new_app.id}"))
          end
        end
      end
    end
  end

  describe(" INcorrect workflow test") do
    describe("#3.visit the new application page") do
      describe("I fail to fill in any of the form fields") do
        describe("I click submit Then I am taken back to the applications page") do
          it("#3.I see a message that I must fill in those fields.") do
            visit("/applications/new")
            expect(page).to(have_content("New Application"))
            fill_in("Street Address",             with: "722 E Kensington Rd")
            fill_in("City",             with: "Los Angeles")
            fill_in("State",             with: "CA")
            fill_in("Zipcode",             with: 90026)
            click_button("Submit")
            @new_app = Application.all.last
            expect(current_path).to(eq("/applications/new"))
          end
        end
      end
    end
  end
end
