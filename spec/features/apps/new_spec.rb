require 'rails_helper'
RSpec.describe "New Application Page" do 
  #   before :each do 
  #   @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  #   @pet_1 = @shelter.pets.create!(adoptable: true, age: 5, breed: "Pug", name: "James")
  #   @application_1 = @pet_1.apps.create!(name: "Karan", address: "124 South Jefferson", city: "Goliad", state: "TX", zip: 72936, description: "Because I care for pets", status: 0)
  # end 

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