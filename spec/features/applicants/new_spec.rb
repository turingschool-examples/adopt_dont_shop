require 'rails_helper'

RSpec.describe 'the new applicant page' do
  describe 'starting an application' do
    it 'has a form' do
      visit "/applicants/new"

      expect(page).to have_field(:name)
      expect(page).to have_field(:street)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip)
      expect(page).to have_field(:good_home)
      expect(page).to have_button("Submit")
    end

    it 'can be submitted' do
      visit "/applicants/new"

      fill_in :name, with: "Maura McGonagle"
      fill_in :street, with: "124 Hill Rd"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80210"
      fill_in :good_home, with: "Fenced in yard, lots of love"

      click_on "Submit" 

      expect(current_path).to eq("/applicants/#{Applicant.last.id}")
    end
  end
  describe "fail to fill any form fields" do
    it "If I don't fill out any form field and press submit, I am
        taken back to 'applicants/new' where I see messages to fill
        those fields" do
      visit "/applicants/new"

      fill_in :name, with: "Maura McGonagle"
      fill_in :street, with: "124 Hill Rd"
      fill_in :city, with: "Denver"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80210"

      click_on "Submit"

      expect(current_path).to eq("/applicants/new")

      
    end
  end
end
