require 'rails_helper'
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
    @app_1 = Application.create!(name: 'bob', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: '', status: 2)
    @app_2 = Application.create!(name: 'sumbit', address: '321 hill ave, Denver, CO, 80021', description: "", pet_names: "", status: 0)

  end
  describe 'When I visit a applications show page' do
    it 'Then I can see application attributes' do
      visit "/applications/#{@app_1.id}"

      expect(page).to have_content("Applicant Name: #{@app_1.name}")
      expect(page).to have_content("Full Address: #{@app_1.address}")
      expect(page).to have_content("Why I am a Good Home: #{@app_1.description}")
      expect(page).to have_content("Application Status: #{@app_1.status}")
      expect(page).to_not have_content("#{@app_2.name}")
      expect(page).to_not have_content("#{@app_2.address}")
      expect(page).to_not have_content("#{@app_2.status}")
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
        expect(page).to_not have_content("#{@pet_1.name}")
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

        expect(current_path).to eq("/applications/#{@app_2.id}")

        expect(page).to have_content("Adoptable Pets: #{@pet_2.name}")
      end
    end

    describe 'Adding a description to an application' do

      it 'I see a section to input my description after adding a pet(s)' do

        visit "/applications/#{@app_2.id}"

        fill_in "pet names", with: 'lobster'
        click_on 'Submit'
        within "#pet-#{@pet_2.id}" do
          click_on "Adopt This Pet"
        end

        # save_and_open_page
        fill_in 'Why i would make a good home', with: 'I am a good pet owner.'
        click_on "Submit This Application"

        expect(current_path).to eq("/applications/#{@app_2.id}")

        expect(page).to_not have_content("in_progress")
        expect(page).to have_content("pending")
        expect(page).to have_content("Why I am a Good Home: I am a good pet owner.")
      end

      it 'I no longer see a section to add more pets aftering adding my description' do

        visit "/applications/#{@app_2.id}"

        fill_in "pet names", with: 'lobster'
        click_on 'Submit'
        within "#pet-#{@pet_2.id}" do
          click_on "Adopt This Pet"
        end
        fill_in "pet names", with: 'bald'
        click_on 'Submit'

        within "#pet-#{@pet_1.id}" do
          click_on "Adopt This Pet"
        end
        # save_and_open_page
        fill_in 'Why i would make a good home', with: 'I am a good pet owner.'
        click_on "Submit This Application"
        expect(page).to_not have_content("Add a Pet to this Application")

      end
    end
    describe 'Partial Matches for Pet Names' do
      it 'And I search for Pets by name Then I see any pet whose name PARTIALLY matches my search' do
        visit "/applications/#{@app_2.id}"

        fill_in "pet names", with: 'ski'
        click_on 'Submit'
        # save_and_open_page
        expect(current_path).to eq("/applications/#{@app_2.id}")
        expect(page).to have_content("#{@pet_3.name}")
        expect(page).to have_content("#{@pet_4.name}")
        expect(page).to_not have_content("#{@pet_1.name}")
      end
    end
  end
end
