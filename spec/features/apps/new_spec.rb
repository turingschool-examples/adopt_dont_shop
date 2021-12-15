require 'rails_helper'
RSpec.describe "New Application Page" do 
  
  describe "When I visit the Pet Index Page" do 
    it 'has a link that takes me to the new app form' do 
      visit "/pets"
      click_link "Start an Application"

      expect(current_path).to eq("/apps/new")
    end 
  end 

  describe "when I visit the Application New Page" do 
    it 'can create a new application' do 
      visit "/apps/new"

      fill_in :name, with: 'George'
      fill_in :address, with: '7722 West Street'
      fill_in :city, with: 'Detroit'
      fill_in :state, with: 'Michigan'
      fill_in :zip, with: 32416

      click_button "Submit"

      # expect(current_path).to eq("/apps/id")
      expect(page).to have_content("George")
    end 

    it 'shows a message when form not completed' do #sad_path_lesson_plan
      visit "/apps/new" 
      
      click_button "Submit"

      expect(page).to have_content("Application Not Created, Required Information Missing")
      expect(page).to have_button("Submit")
    end 
  end 
end