require 'rails_helper'

RSpec.describe 'applications new page features' do
  before(:each) do
    @applicant_1 = Application.create!(name: 'Rumiko Takahashi', address: '4307 Saddle Creek Place', city: "Orlando", state: "Florida", zip_code: 32829, status: 0, description: 'Single and has great income, flexible schedule for pet needs.')
  end

  describe 'As a visitor' do
    context 'When I visit a new application page' do
      it 'has a form with several attributes to fill out' do
        visit "/pets"  
        click_link "Start an Application"
        expect(page).to have_selector("form")
        expect(page).to have_content("Name")
        expect(page).to have_content("Street address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zip code")
        expect(page).to have_content("Description of why you would be a good caretaker")

      end

      it "I fill in the form and click submit and then am taken to a new show page that has all of my information on it" do 
        visit "/pets"  

        click_link "Start an Application"
        # save_and_open_page
        fill_in "Name", with: "Hady"
        fill_in "address", with: "1133 Lemon Drive"
        fill_in "City", with: "Melbourne"
        fill_in "State", with: "Florida"
        fill_in "Zip code", with: "32901"
        fill_in "description", with: "I have a yard with lots of space and 3 kids who want to have a dog!"

        click_button("Submit") 
        expect(current_path).to eq("/applications/#{Application.last.id}")

        expect(page).to have_content("Hady")
        expect(page).to have_content("1133 Lemon Drive")
        expect(page).to have_content("Melbourne")
        expect(page).to have_content("Florida")
        expect(page).to have_content("32901")
        expect(page).to have_content("I have a yard with lots of space and 3 kids who want to have a dog!")
        expect(page).to have_content("Status of Application: In Progress")
      end

      it "if i fail to fill in any of the form fields and click submit, i am redirected to the new applications page and told to fill in the fields" do 
        visit "/applications/new"

        fill_in "address", with: "1133 Lemon Drive"
        fill_in "State", with: "Florida"
        fill_in "Zip code", with: "32901"
        fill_in "description", with: "I have a yard with lots of space and 3 kids who want to have a dog!"
        click_button("Submit") 
save_and_open_page
        expect(page).to have_content("Name can't be blank")
        expect(page).to have_content("City can't be blank")

      end
    end
  end
end