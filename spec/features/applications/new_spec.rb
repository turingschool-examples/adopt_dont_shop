require 'rails_helper' 

RSpec.describe 'applications new' do 
    it 'has a form to create new application' do 
        visit '/applications/new' 
        fill_in "Name", with: "Tony Soprano" 
        fill_in "Street Address", with: "1234 Ever Lane"
        fill_in "City", with: "Jersey City" 
        fill_in "State", with: "NJ" 
        fill_in "Zip Code", with: "12345"
        click_button "Submit"

        expect(current_path).to eq "/applications/#{Application.all.last.id}"
        expect(page).to have_content("Tony Soprano")
        expect(page).to have_content("1234 Ever Lane, Jersey City, NJ 12345")
        expect(page).to have_content("In Progress")
    end

    it 'alerts user of an incomplete form' do 
        visit '/applications/new' 
        fill_in "Name", with: "Tony Soprano" 
        fill_in "Street Address", with: "1234 Ever Lane"
        fill_in "City", with: "Jersey City" 
        fill_in "Zip Code", with: "12345"

        click_button "Submit"
        # save_and_open_page

        expect(current_path).to eq "/applications/new"
        expect(page).to have_content "Please fill in all fields."
    end
end