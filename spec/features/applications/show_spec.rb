require 'rails_helper'
# Application Show Page
#
# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
RSpec.describe 'Application show page' do
  before do
    Application.destroy_all
    Pet.destroy_all
    Shelter.destroy_all

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 7, breed: 'corgie', name: 'Skippy', shelter_id: shelter.id)
    @pet_4 = Pet.create(adoptable: true, age: 5, breed: 'lab', name: 'skippy', shelter_id: shelter.id)
    @app_1 = Application.create!(name: 'bob', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: 'Joe, Champ, Pixie', status: 2)
    @app_2 = Application.create!(name: 'sumbit', address: '321 hill ave, Denver, CO, 80021', description: "", pet_names: "", status: 0)

  end
  describe 'When I visit a applications show page' do
    it 'Then I can see application attributes' do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content("Applicant Name: #{@app_1.name}")
      expect(page).to have_content("Full Address: #{@app_1.address}")
      expect(page).to have_content("Why I am a Good Home: #{@app_1.description}")
      expect(page).to have_content("Adoptable Pets: #{@app_1.pet_names}")
      expect(page).to have_content("Application Status: #{@app_1.status}")
    end

    describe 'When and application has not been submitted' do
      it 'I see a section on the app to add a pet to the application' do
        visit "/applications/#{@app_2.id}"

        expect(page).to have_content("Add a Pet to this Application")

        fill_in "pet names", with: 'Skippy'
        click_on 'Submit'

        expect(current_path).to eq("/applications/#{@app_2.id}")
        expect(page).to have_content("#{@pet_3.name}")
        expect(page).to have_content("#{@pet_4.name}")
      end
    end

    describe 'Adding pets to an application' do

      it 'I see button to adopt a pet, clicking it adds pet to my application' do
        visit "/applications/#{@app_2.id}"

        expect(page).to have_content("Adoptable Pets:")
        fill_in "pet names", with: 'Lobster'
        click_on 'Submit'

        within "#pet-#{@pet_2.id}" do
          click_on "Adopt This Pet"
        end
        # save_and_open_page

        expect(current_path).to eq("/applications/#{@app_2.id}")

        expect(page).to have_content("Adoptable Pets: #{@pet_2.name}")


      end



    end
  end
end
