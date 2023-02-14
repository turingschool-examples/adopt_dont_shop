require "rails_helper"

RSpec.describe "Admin Application Show Page" do
  describe "As a visitor" do
    describe "When I visit an admin application show page '/admin/applications/:id'" do
      before(:each) do 
        @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @application_1 = Application.create!(name: "Brian", street_address: "853 West Linden st", city: "Louisville", state: "colorado", zip_code: "80027", description: "I like animals", status: 1)
        @application_2 = Application.create!(name: "John", street_address: "853 West Linden st", city: "Louisville", state: "colorado", zip_code: "80027", description: "I like animals", status: 1)
        @rylo = @application_1.pets.create!(adoptable: true, age: 1, breed: "Lab", name: "Rylo", shelter: @shelter_1)
        PetApplication.create!(application_id: @application_2.id, pet_id: @rylo.id)

        visit "/admin/applications/#{@application_1.id}"
      end

      it 'can see an approval button next to each pet which approves the pet with an indicator, returns user to show page and no longer has button' do
        expect(page).to have_content("Application: #{@application_1.id}")
      
        within(".pet") { 
          expect(page).to have_content("Name: Rylo")
          expect(page).to have_content("Age: 1")
          expect(page).to have_content("Breed: Lab")
          expect(page).to have_content("Adoptable: true")
          expect(page).to have_content("Shelter: Aurora shelter")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")

        }

        click_on "Approve"

        expect(current_path).to eq("/admin/applications/#{@application_1.id}")

        within(".pet") {
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
          expect(page).to have_content("Status: Approved")
        }
      end

      it 'can see a reject button next to each pet which rejects the pet with an indicator, returns user to show page and no longer has button' do
        expect(page).to have_content("Application: #{@application_1.id}")
      
        within(".pet") { 
          expect(page).to have_content("Name: Rylo")
          expect(page).to have_content("Age: 1")
          expect(page).to have_content("Breed: Lab")
          expect(page).to have_content("Adoptable: true")
          expect(page).to have_content("Shelter: Aurora shelter")
          expect(page).to have_button("Approve")
          expect(page).to have_button("Reject")
        }

        click_on "Reject"

        expect(current_path).to eq("/admin/applications/#{@application_1.id}")

        within(".pet") {
          expect(page).to_not have_button("Approve")
          expect(page).to_not have_button("Reject")
          expect(page).to have_content("Status: Rejected")
        }
      end

      context "When there are two applications in they system for the same pet" do 
        it 'when I approve or reject a pet on one application, the other application is not affected' do 
          click_on "Approve"

          expect(current_path).to eq("/admin/applications/#{@application_1.id}")

          visit "/admin/applications/#{@application_2.id}"

          within(".pet") {
            expect(page).to have_button("Approve")
            expect(page).to have_button("Reject")
            expect(page).to have_content("Status: In Progress")
          }
        end
      end
    end
  end 
end 