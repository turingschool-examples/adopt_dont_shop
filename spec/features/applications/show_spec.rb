# [ ] done

# 1. Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Application
# - Full Address of the Application including street address, city, state, and zip code
# - Description of why the application says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe "Application Show Page" do
  before :each do
    @application_1 = Application.create!(
      name: "Bob",
      street_address: "123 Leaf Street",
      city: "Denver",
      state: "CO",
      zip_code: 80020,
      description: "Work from home",
      status: "In Progress"
    )

    @shelter_1 = Shelter.create!(
      foster_program: true,
      name: "Healthy Paws",
      city: "Denver",
      rank: 3
    )

    @pet_1 = @application_1.pets.create!(
      name: "Pepper",
      adoptable: true,
      age: 4,
      breed: "Pitbull",
      shelter_id: @shelter_1.id
    )
      
    @pet_2 = @application_1.pets.create!(
      name: "Daisy",
      adoptable: true,
      age: 14,
      breed: "Beagle",
      shelter_id: @shelter_1.id
    )
  end

  describe "User Story 1" do
    describe "User visits '/applications/:id'" do
      it 'has application attributes' do
        visit "/applications/#{@application_1.id}"

        save_and_open_page
        
        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.full_address)
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@application_1.status)

        click_link "Pepper"

        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end
    end
  end
end