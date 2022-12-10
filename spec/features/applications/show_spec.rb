# [ ] done

# 1. Application Show Page

# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search

require 'rails_helper'

RSpec.describe "Application Show Page" do
  before :each do
    @shelter_1 = Shelter.create!(
      foster_program: true,
      name: "Healthy Paws",
      city: "Denver",
      rank: 3
    )

    @application_1 = Application.create!(
      name: "Bob",
      street_address: "123 Leaf Street",
      city: "Denver",
      state: "CO",
      zip_code: 80020,
      description: "Work from home",
      status: "In Progress"
    )
  end

  describe "User Story 1" do
    describe "User visits '/applications/:id'" do
      it 'has application attributes' do
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

        visit "/applications/#{@application_1.id}"
        
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

  describe "User Story 4" do
    describe "User application is in progress" do
      it 'has a section to search for a pet' do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_field(:search)
        expect(page).to have_button("Search For Pet!")
      end

      it 'returns list of pets with exact name match' do
        pet_1 = Pet.create!(
          name: "Pepper",
          adoptable: true,
          age: 4,
          breed: "Pitbull",
          shelter_id: @shelter_1.id
        )

        visit "/applications/#{@application_1.id}"

        fill_in(:search, with: "Pepper")
        click_button("Search For Pet!")

        expect(page).to have_link("Pepper", href: "/pets/#{pet_1.id}")
      end
    end
  end

  #As a visitor
  # When I visit an application's show page
  # And I search for a Pet by name
  # And I see the names Pets that match my search
  # Then next to each Pet's name I see a button to "Adopt this Pet"
  # When I click one of these buttons
  # Then I am taken back to the application show page
  # And I see the Pet I want to adopt listed on this application

  describe "User story 5" do
    describe "Search a pet by name" do
      it "has a button 'Adopt this Pet' next to the pet's name" do
        pet_1 = Pet.create!(
          name: "Pepper",
          adoptable: true,
          age: 4,
          breed: "Pitbull",
          shelter_id: @shelter_1.id
        )
         
        visit "/applications/#{@application_1.id}"

        fill_in(:search, with: "Pepper")
        click_button("Search For Pet!")

        expect(page).to have_button("Adopt #{pet_1.name}!")
        
        click_button("Adopt #{pet_1.name}!")
        
        within("#application_pets") do
          expect(page).to have_content("#{pet_1.name}")
        end

        expect(current_path).to eq("/applications/#{@application_1.id}")
      end
    end
  end
end