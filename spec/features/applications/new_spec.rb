require 'rails_helper'

RSpec.describe 'Application New Page', type: :feature do
  describe 'form' do
    it 'has a form to input attributes' do
        visit "/applications/new"

        expect(page).to have_content("New Application")

        fill_in(:name, with: "Leonardo DiCaprio")
        fill_in(:street_address, with: "777 Hollywood lame")
        fill_in(:city, with: "Hollywood")
        fill_in(:state, with: "CA")
        fill_in(:zip_code, with: 33004)

        click_on("Submit")

        expect(page).to have_current_path("/applications/#{Application.last.id}")
        expect(page).to have_content("Leonardo DiCaprio")
        expect(page).to have_content("Full address: 777 Hollywood lame, Hollywood, CA 33004")
        expect(page).to have_content("In Progress")
        expect(page).to have_content("Applicant statement:")
    end
  end
end
