require 'rails_helper'

RSpec.describe "Applications New" do
    describe "Flash Error" do
        it "shows error message when a form is submitted with blank fields" do
            visit '/applications/new'
            fill_in :first, with: "Leo"
            click_on "Submit"
            save_and_open_page

            expect(page).to have_content "Error, fill in all fields"
        end
    end
end