require 'rails_helper'

RSpec.describe "#show" do
  describe 'user story 2' do
    it 'has a form to create a new application' do
      visit "/applications/new"

      fill_in "applicant_name", with: "Test"
      fill_in "app_street", with: "123 Court Dr"
      fill_in "app_city", with: "San Francisco"
      fill_in "app_state", with: "California"
      fill_in "app_zip_code", with: "90439"
      fill_in "description", with: "Cuz I'm fresh"
      click_button "Submit Application"

      expect(current_path).to eq "/applications/#{Application.last.id}"
      expect(page).to have_content("#{Application.last.applicant_name}'s")
      expect(page).to have_content("Applicant's Address: 123 Court Dr,")
      expect(page).to have_content("San Francisco")
      expect(page).to have_content("California")
      expect(page).to have_content("90439")
      expect(page).to have_content("Applicant's Reason For Adopting: Cuz I'm fresh")
    end
  end

  describe "User Story 3" do
    it "redirect to the new application page application form is incomplete" do
      visit "/applications/new"

      fill_in "app_street", with: "123 Court Dr"
      fill_in "app_city", with: "San Francisco"
      fill_in "app_state", with: "California"

      click_button "Submit Application"
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Applicant name can't be blank")
    end
  end
end
