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
        # expect(page).to have_content("Why would you be a good home for a pet")
        expect(page).to have_button("Submit")
      end

      describe "When I fill out the form and click 'Submit'" do
        before(:each) do
          visit "/applications/new"
          fill_in :first, with: "Joe"
          fill_in :last, with: "Hilby"
          fill_in :street, with: "123 Street"
          fill_in :city, with: "AnyTown"
          fill_in :state, with: "AnyState"
          fill_in :zip, with: "86753"
          # fill_in :good_home, with: "Its the best of homes"
        end
        it "I am taken to /applications/:id" do
          click_on "Submit"

          expect(current_route).to eq("")
        end
      end
    end
  end
end
