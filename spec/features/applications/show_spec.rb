require 'rails_helper'

RSpec.describe 'the application show' do
  before (:each) do
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @scrappy = Pet.create!(name: "Scrappy", age: 3, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
    @application = Application.create!(status: "In Progress", name: "Murmuring Savannah", street: '123 Main',city: 'Leadville', state: 'CO',
    zip: 11111, description: "I'm a real cool cat")
  end

  describe "when I visit an applicat!!ion's show page" do
    it "shows the applicant and all it's attributes" do

      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.street)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@application.status)
    end

    it "shows me a section Add a Pet to this Application" do

      visit "/applications/#{@application.id}"

      expect(page).to have_content("Add a Pet to this Application")
    end

    it "lets me search for pets" do

      visit "/applications/#{@application.id}"

      expect(page).to_not have_content("Scooby")
      expect(page).to_not have_content("Scrappy")

      fill_in("search", with: "Scooby")
      click_on "Search"

      expect(page).to have_content("Scooby")
      expect(page).to_not have_content("Scrappy")

      visit "/applications/#{@application.id}"

      fill_in("search", with: "Sc")
      click_on "Search"

      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")

    end
      # As a visitor
      # When I visit an application's show page
      # And I search for a Pet by name
      # And I see the names Pets that match my search
      # Then next to each Pet's name I see a button to "Adopt this Pet"
      # When I click one of these buttons
      # Then I am taken back to the application show page
      # And I see the Pet I want to adopt listed on this application
    it "has a button to Adopt this Pet" do
      visit "/applications/#{@application.id}"

      expect(page).to_not have_content("Adopt this Pet")

      fill_in("search", with: "Scooby")
      click_on "Search"
      expect(page).to have_button("Adopt this Pet")
    end

    it "lets me add the pet to my application" do

      visit "/applications/#{@application.id}"

      fill_in("search", with: "Scrappy")
      click_on "Search"
      click_button "Adopt this Pet"
      save_and_open_page

      expect("Scrappy").to appear_before("Add a Pet to this Application")

      within('#app') do
        expect(page).to have_content("Scrappy")
      end
    end
  end
end
