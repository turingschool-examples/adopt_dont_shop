require 'rails_helper'

RSpec.describe "#show" do
  describe 'user story 2' do
    it 'has a form to create a new application' do
      visit "/applications/new"

      fill_in "Your Name", with: "Test"
      fill_in "Street Address", with: "123 Court Dr"
      fill_in "City", with: "San Francisco"
      fill_in "State", with: "California"
      fill_in "Zip Code", with: "90439"
      fill_in "Description", with: "Cuz I'm fresh"
      click_button "Submit Application"

      expect(current_path).to eq "/applications/#{Application.last}"
    end
  end
end
