require 'rails_helper'

RSpec.describe "Application show page", type: :feature do
  describe "As a visitor" do 
    describe "When I visit an application's show page" do 
      before(:each) do
        @application = Application.create!(name: "Brian", street_address: "853 West Linden st", city: "Louisville", state: "colorado", zip_code: "80027", description: "I like animals")
        @shelter = Shelter.create!(foster_program: true, name: "Boulder Humane Society", city: "Boulder", rank: 1)
        @jax = @application.pets.create!(adoptable: false, age: 4, breed: "ACD", name: "Jax", shelter: @shelter)
        @rylo = @application.pets.create!(adoptable: false, age: 1, breed: "Lab", name: "Rylo", shelter: @shelter)
        
        visit "/applications/#{@application.id}"
      end

      it "can see application attributes name, address, description, status" do 
        expect(page).to have_content(@application.name)
        expect(page).to have_content(@application.street_address)
        expect(page).to have_content(@application.city)
        expect(page).to have_content(@application.state)
        expect(page).to have_content(@application.zip_code)
        expect(page).to have_content(@application.description)
        expect(page).to have_content(@application.status)

        expect(page).to have_link("#{@jax.name}", href: "/pets/#{@jax.id}")
        expect(page).to have_link("#{@rylo.name}", href: "/pets/#{@rylo.id}")

        click_link "#{@jax.name}"
        expect(current_path).to eq("/pets/#{@jax.id}")

        visit "/applications/#{@application.id}"
        click_link "#{@rylo.name}"
        expect(current_path).to eq("/pets/#{@rylo.id}")
      end

      context "the application has not been submitted" do
        it "can see a section on the page to 'Add a Pet to this Application'" do
          @application.pets.create!(adoptable: true, age: 2, breed: "Shih Tzu", name: "Rylo", shelter: @shelter)
          within(".add_pet") { expect(page).to have_content("Add a Pet to this Application") }
          within(".add_pet") { expect(page).to have_content("Search for pet by name:") }

          fill_in :pet_name, with: "Rylo"
          click_button "Submit"

          expect(current_path).to eq("/applications/#{@application.id}")
          within(".add_pet") { expect(page).to have_content("Rylo") }
          within(".add_pet") { expect(page).to have_content("Lab") }
          within(".add_pet") { expect(page).to have_content("Shih Tzu") }
        end

        it 'can see a button to "Adopt this Pet" next to each pets name which adds the pet to this application' do 

          fill_in :pet_name, with: "Rylo"
          click_button "Submit"

          within('.pet') { expect(page).to have_button("Adopt this Pet")}

          click_button "Adopt this Pet"

          expect(current_path).to eq("/applications/#{@application.id}")
          
        end

        it 'can have the option to update the description and submit the application once pets have been added' do
          within('.submit_application') { expect(page).to have_content("Finalize Submission") }
          within('.submit_application') { expect(page).to have_field(:description, with: "I like animals")}
          within('.submit_application') { expect(page).to have_button("Submit Application") }
          
          fill_in :description, with: "I REALLY like animals"
          click_button "Submit Application"

          expect(current_path).to eq("/applications/#{@application.id}")
          expect(page).to_not have_button("Add this Pet")
          within('.application_status_pending') { expect(page).to have_content("Pending") }
        end   
      end
    end
  end
end