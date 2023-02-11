require 'rails_helper'

RSpec.describe 'applications show page features' do
  before(:each) do
    @applicant_1 = Application.create!(name: 'Rumiko Takahashi', address: '4307 Saddle Creek Place', city: "Orlando", state: "Florida", zip_code: 32829, status: 0, description: 'Single and has great income, flexible schedule for pet needs.')
    @shelter1= Shelter.create!(name: "Caring Dogs", foster_program: true, city: "Puerto escondido", rank: 1)
    @pet1 = Pet.create!(adoptable: true, age: 23, breed: "Golden", name: "Norma", shelter_id: @shelter1.id)

  end

  describe 'As a visitor' do
    context 'When I visit an applications show page' do
      it 'shows the applicants attributes' do
        visit "/applications/#{@applicant_1.id}"
        # save_and_open_page
        expect(page).to have_content("Name: #{@applicant_1.name}")
        expect(page).to have_content("Address: #{@applicant_1.address}")
        expect(page).to have_content(@applicant_1.city)
        expect(page).to have_content(@applicant_1.state)
        expect(page).to have_content(@applicant_1.zip_code)
        expect(page).to have_content("Status: In_Progress")
        expect(page).to have_content("Description: #{@applicant_1.description}")
      end

      context "the application has not yet been submitted" do 
        it "has a section on the page to 'Add a Pet to this Application'" do 
          visit "/applications/#{@applicant_1.id}"

          expect(page).to have_content("Add a Pet to this Application")

        end

        it "that section has an input where I can search for Pets by name" do 

          visit "/applications/#{@applicant_1.id}"
          expect(page).to have_selector("form")

        end

        it "when I fill in this field with a Pet's name and click submit, I am taken back to the application show page and under the search bar I see any pet whose name matches my search" do 
          visit "/applications/#{@applicant_1.id}"
          fill_in "search", with: "Norma"
          click_button "Search"
          save_and_open_page
          expect(current_path).to eq("/applications/#{@applicant_1.id}")

        end
      end

    end
  end
end