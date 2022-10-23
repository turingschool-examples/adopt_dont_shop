require 'rails_helper'

RSpec.describe "application show page", type: :feature do
  describe 'as a user' do
    before(:each) do
      @app = Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")
      @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @scooby = @shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
      @sm_scooby = @shelter.pets.create!(name: 'Scooby', age: 6, breed: 'Chihuahua', adoptable: true)
      @scrappy = @shelter.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true)
    end

    describe 'when I visit the page /applications/:id' do
      it 'shows a unique application and its attributes' do
        visit "/applications/#{@app.id}"

        expect(page).to have_content(@app.name)
        expect(page).to have_content(@app.street_address)
        expect(page).to have_content(@app.city)
        expect(page).to have_content(@app.state)
        expect(page).to have_content(@app.zipcode)
        expect(page).to have_content(@app.description)
        expect(page).to have_content(@app.status)
      end
    end

    describe 'when the application has not been submitted, I see a section on the
    page to add a pet to the application' do 
      it 'has an input where I can search for pets by name. when I fill in this field
      with a pets name and I click submit, I am redirected back to the application 
      show page. under the search bar, I see any pet whose name matches my search' do
        visit "/applications/#{@app.id}"
            
        within("#add_pet")
        fill_in 'Search for Pets by Name', with: 'Scooby'
            
        click_button('Submit') 
        expect(current_path).to eq("/applications/#{@app.id}")
        expect(page).to have_content(@scooby.name)
        expect(page).to have_content(@scooby.age)
        expect(page).to have_content(@scooby.breed)
        expect(page).to have_content(@scooby.adoptable)
        expect(page).to have_content(@sm_scooby.name)
        expect(page).to have_content(@sm_scooby.age)
        expect(page).to have_content(@sm_scooby.breed)
        expect(page).to have_content(@sm_scooby.adoptable)
      end
    end

    describe 'when I see the names of pets that match my search' do 
      it 'has a button next to each pets name to (adopt this pet)' do
        visit "/applications/#{@app.id}"

        within("#add_pet")
        fill_in 'Search for Pets by Name', with: 'Scooby'
            
        click_button('Submit') 
        expect(current_path).to eq("/applications/#{@app.id}")
        expect(page).to have_selector(:link_or_button, "ADOPT THIS PET")
      end

      it 'when I click one of these buttons, I am taken back to the application show 
      page and the pet I want to adopt is listed on this application' do
        visit "/applications/#{@app.id}"

        fill_in 'Search for Pets by Name', with: 'Scooby' 
        click_button('Submit') 

        page.first(:button, 'ADOPT THIS PET').click
        expect(current_path).to eq("/applications/#{@app.id}")
        expect(page).to have_content(@scooby.name)
      end
    end
  end
end