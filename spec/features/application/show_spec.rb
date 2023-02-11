require 'rails_helper'

RSpec.describe 'Application Show Page' do

  let!(:application) { Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, description: "I love them") }
  let!(:shelter_1) {Shelter.create!(name: "Dumb Friends League", foster_program: true, city: "Denver", rank: "1") }
  let!(:pet_1) { Pet.create!(shelter_id: shelter_1.id, adoptable: true, age: 6, breed: "Soft Coated Wheaton Terrier", name: "Larry") }

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

  describe 'User Story 4' do
    describe "When I visit an application's show page" do 
      describe "And that application has not been submitted," do
        it "Then I see a section on the page to 'Add a Pet to this Application'" do
                   
          visit "/applications/#{Application.last.id}"

          expect(page).to have_content("Add a Pet to this Application")

          fill_in :search, with: "#{pet_1.name}"

          click_on "Search"

          expect(page).to have_content("Larry")
        end
      end
    end
  end
end