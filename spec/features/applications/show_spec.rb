require "rails_helper"

RSpec.describe "Applications" do
  describe "when I visit /applications/:id" do
    describe "User story 1 / As a user " do
      it " I see the applicant name, full adress, description, name of all pet( pet name is link to show page), application status" do
        application_1 = Application.create!(name: "joe", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "This is a description")
        visit "applications/#{application_1.id}"
        
        expect(page).to have_content("Applicant Name: #{application_1.name}")
        expect(page).to have_content("Address: #{application_1.address}")
        expect(page).to have_content("Description: #{application_1.description}")
        expect(page).to have_content("Pets Name(s): #{pet.name}")
        expect(page).to have_content("Application Form Status: #{application_1.status}")

        #expect(page).to have a link to pet show page
      end
    end
  end 
end