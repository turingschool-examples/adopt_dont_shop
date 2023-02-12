require 'rails_helper'

RSpec.describe 'Application Show Page' do

  let!(:application) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525) }
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }
  let!(:pet_1) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry") }
  let!(:pet_2) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 3, breed: "Soft Coated Wheaton Terrier", name: "Lady") }


  describe 'User Story 1' do
    describe 'When I visit an applications show page' do
      it 'I see applicant info' do
        visit "/applications/#{application.id}"

        expect(page).to have_content(application.name)
        expect(page).to have_content(application.street_address)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip_code)
        expect(page).to have_content(application.description)
        expect(page).to have_content(application.app_status)
      end
    end
  end

  describe 'User Story 4, 5, 6 & 7' do
    describe "application's show page" do 
      describe "And that application has not been submitted," do
        it "Then I see a section on the page to 'Add a Pet to this Application'" do
                   
          visit "/applications/#{Application.last.id}"

          expect(page).to have_content("Add a Pet to this Application")

          fill_in :search, with: "#{pet_1.name}"

          click_on "Search"

          expect(page).to have_content("Larry")
        end
      end

      describe "I search for a Pet by name, see results" do
        it "next to each Pet's name I see a button to 'Adopt this Pet'" do

          visit "/applications/#{Application.last.id}"
          fill_in :search, with: "#{pet_1.name}"
          click_on "Search"

          expect(page).to have_button("Adopt this Pet")

        end

        it "I am redirected to application show page and see the pet I want to adopt listed on application" do

          visit "/applications/#{Application.last.id}"
          fill_in :search, with: "#{pet_1.name}"
          click_on "Search"
          click_on "Adopt this Pet"
          expect(current_path).to eq("/applications/#{Application.last.id}")
          expect(page).to have_content(pet_1.name)
        end
      end

      describe "And I have added one or more pets to the application" do
        it "Then I see a section to submit my application" do
          visit "/applications/#{Application.last.id}"
          fill_in :search, with: "#{pet_1.name}"
          click_on "Search"
          click_on "Adopt this Pet"

          expect(page).to have_content("Why I would make a good owner for these pet(s)")
          expect(page).to have_button("Submit my application")
        end

        describe 'fill in input, click submit, back to app show page' do
          it 'should show application as pending, seeing pets to adopt and no section to add pets' do
            visit "/applications/#{Application.last.id}"
            fill_in :search, with: "#{pet_1.name}"
            click_on "Search"
            click_on "Adopt this Pet"

            fill_in :description, with: "I love pets"
            click_on "Submit my application"

            expect(current_path).to eq("/applications/#{Application.last.id}")
            expect(page).to have_content("Larry")
            expect(page).to have_content("Pending")
          end
        end

        describe 'User Story 7' do
          it "if I don't click on adopt this pet, I don't see section to submit app" do
            visit "/applications/#{Application.last.id}"
            fill_in :search, with: "#{pet_1.name}"
            click_on "Search"

            expect(page).to_not have_content("Why I would make a good owner for these pet(s)")
            expect(page).to_not have_button("Submit my application")
          end
        end

        describe 'User Story 8 & 9' do
          it "I enter my search and see any pet whose name partially matches my search" do
            visit "/applications/#{Application.last.id}"
            fill_in :search, with: "La"
            click_on "Search"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_2.name)
          end

          it "I enter my search and see any pet whose name partially matches my search" do
            visit "/applications/#{Application.last.id}"
            fill_in :search, with: "la"
            click_on "Search"

            expect(page).to have_content(pet_1.name)
            expect(page).to have_content(pet_2.name)
          end
        end
      end
    end
  end
end