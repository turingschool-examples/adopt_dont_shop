require "rails_helper"

RSpec.describe "Applications" do
  describe "when I visit /applications/:id" do
    describe "User story 1 / As a user " do
      it " I see the applicant name, full adress, description, name of all pet( pet name is link to show page), application status" do
        vist "applications/#{applications.id}"

        expect(page).to have_content("Applicant Name: #{applicant.name}")
        expect(page).to have_content("Adress: #{applicant.address}")
        expect(page).to have_content("Description: #{applicant.description}")
        expect(page).to have_content("Pets Name(s): #{pet.name}")
        expect(page).to have_content("Application Form Status: #{application.status}")

        #expect(page).to have a link to pet show page
      end
    end
  end 
end