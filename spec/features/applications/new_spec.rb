require 'rails_helper'

RSpec.describe 'Application New' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  end
  describe "When I visit the New Application Page" do
    describe "Then I see" do
      it "A form with a secion for first, last, street, city, state, & zip" do
        visit "/applications/new"

        expect(page).to have_content("First")
        expect(page).to have_content("Last")
        expect(page).to have_content("Street")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zipcode")
        expect(page).to have_content("Tell us about your home:")
        expect(page).to have_button("Submit")
      end

      describe "When I fill out the form and click 'Submit'" do
        before(:each) do
          visit "/applications/new"
          fill_in :last, with: "Hilby"
          fill_in :street, with: "123 Street"
          fill_in :city, with: "AnyTown"
          fill_in :state, with: "AnyState"
          fill_in :zip, with: "86753"
          fill_in :description, with: "Its the best of homes"
        end
        it "I am taken to /applications/:id" do
          fill_in :first, with: "Joe"
          click_on "Submit"

          expect(current_path).to eq("/applications/#{Application.last[:id]}")
        end

        it "see an indicatior that this application is 'In Progress'" do
          fill_in :first, with: "Joe"
          click_on "Submit"

          expect(page).to have_content("In Progress")
        end

        it "fail to fill out part of the form" do
          click_on "Submit"

          expect(page).to have_content("Error: First can't be blank")
          expect(page).to have_current_path("/applications/new")
        end
      end
    end
  end
end
