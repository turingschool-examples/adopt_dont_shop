require 'rails_helper'

RSpec.describe 'new application' do
  describe 'When I visit the pet index page' do
    before :each do
      @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    end

    describe 'I see a link to start an application' do
      describe 'When I click the link I am taken to the new application page' do
        describe 'I see a form' do
          it 'links to the new application page' do
            visit '/pets'

            click_link "Start an Application"

            expect(current_path).to eq('/applications/new')
          end

          it 'displays an application form and redirects to the new application page' do
            visit '/applications/new'

            fill_in("Name", with: "Shelby Waters")
            fill_in("Street address", with: "274 West 11th St")
            fill_in("City", with: "Myers Flatt")
            select("NJ", from: "State")
            fill_in("Zipcode", with: "12447")
            fill_in("Please add a description for why you would make a good home:", with: "I'm lonely")

            click_on "Submit"

            expect(current_path).to eq("/applications/#{Application.last.id}")

            expect(page).to have_content("Shelby Waters")
            expect(page).to have_content("274 West 11th St, Myers Flatt, NJ, 12447")
            expect(page).to have_content("I'm lonely")
            expect(page).to have_content("In Progress")
          end

          it 're-renders the application form if any fields are not filled in' do
            visit '/applications/new'

            fill_in("Name", with: "Shelby Waters")
            fill_in("Street address", with: "274 West 11th St")

            click_on "Submit"

            expect(page).to have_content("Please fill in all fields")
          end
        end
      end
    end
  end
end
