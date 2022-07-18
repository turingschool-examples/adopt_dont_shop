require 'rails_helper'

RSpec.describe 'Show application', type: :feature do
  before :each do
    @dog_homes = Shelter.create!(name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    @app_1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'New York',
                                        state: 'NY', zipcode: 10_001)
    @app_2 = Application.create!(name: 'Jane Doe', street_address: '456 Main St', city: 'Boston',
                                        state: 'MA', zipcode: 10_002)
    @roofus = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: @dog_homes.id)
    @bowow = Pet.create!(name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: @dog_homes.id)
    @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @roofus.id)
    
  end 


  it 'shows the application' do
    visit "applications/#{@app_1.id}"

    within '#app_information' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('123 Main St')
      expect(page).to have_content('New York')
      expect(page).to have_content('NY')
      expect(page).to have_content(10_001)
      expect(page).to have_content('Roofus')

      expect(page).to have_no_content('Jane Doe')
      expect(page).to have_no_content('456 Main St')
      expect(page).to have_no_content('Boston')
      expect(page).to have_no_content('MA')
      expect(page).to have_no_content(10_002)
    end
  end

  it 'clicks an application pets and it opens that pets show page' do
    visit "applications/#{@app_1.id}"

    click_link 'Roofus'

    expect(current_path).to eq("/pets/#{@roofus.id}")
  end

  it 'searches for a pet and adds that pet to the application' do
    visit "applications/#{@app_1.id}"

    within('#pet_search') do
      fill_in 'search_name', with: 'Bowow'
      click_on('Search')
    end

    expect(current_path).to eq("/applications/#{@app_1.id}")

    within('#pet_found') do
      expect(page).to have_content('Bowow')
      expect(page).to have_button('Add to Application')
    end
  end

  it 'finds a pet by searching for' do
    visit "applications/#{@app_1.id}"

    within '#app_information' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('123 Main St')
      expect(page).to have_content('New York')
      expect(page).to have_content('NY')
      expect(page).to have_content(10_001)
      expect(page).to have_content('Roofus')
      expect(page).to have_no_content('Bowow')
    end

    within('#pet_search') do
      fill_in 'search_name', with: 'Bowow'
      click_on('Search')
    end

    within('#pet_found') do
      click_on('Add to Application')
    end

    within '#app_information' do
      expect(page).to have_content('John Doe')
      expect(page).to have_content('123 Main St')
      expect(page).to have_content('New York')
      expect(page).to have_content('NY')
      expect(page).to have_content(10_001)
      expect(page).to have_content('Roofus')
      expect(page).to have_content('Bowow')
    end
  end

  it 'prevents the same pet from being added twice to the same applicaiton' do
    dog_homes = Shelter.create!(id: 1, name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
    application_1 = Application.create!(id: 1, name: 'John Doe', street_address: "123 Main St", city: "New York", state: "NY", zipcode: 10001, description: "I love dogs")
    andrew = Pet.create!(id: 1, name: 'Andrew', age: 2, breed: 'pit bull', adoptable: true, shelter_id: 1)
    fido = Pet.create!(id: 2, name: 'Fido', age: 3, breed: 'labrador', adoptable: true, shelter_id: 1)
    pet_application_1 = PetApplication.create!(id: 1, application_id: 1, pet_id: 1)

    visit "applications/#{application_1.id}"

    within "#app_information" do
     expect(page).to have_no_content("Fido")
    end

    within("#pet_search") do
      fill_in "search_name", with: "Fido"
      click_on("Search")
    end

    within("#pet_found") do
      click_on("Add to Application")
    end

    within("#app_information") do
      expect(page).to have_content("Fido", count: 1)
    end

    within("#pet_search") do
      fill_in "search_name", with: "Fido"
      click_on("Search")
    end

    within("#pet_found") do
      click_on("Add to Application")
    end

    within("#app_information") do
      expect(page).to have_content("Fido", count: 1)
    end

  end

  it 'searches and finds a pet using only part of the name and locates that pet' do
    visit "applications/#{@app_1.id}"

    within('#pet_search') do
      fill_in 'search_name', with: 'Bo'
      click_on('Search')
    end

    expect(current_path).to eq("/applications/#{@app_1.id}")

    within('#pet_found') do
      expect(page).to have_content('Bowow')
      expect(page).to have_button('Add to Application')
    end
  end

  it 'searches for and finds a pet with a partial match' do

    visit "applications/#{@app_1.id}"

    within('#pet_search') do
      fill_in 'search_name', with: 'wo'
      click_on('Search')
    end

    expect(current_path).to eq("/applications/#{@app_1.id}")

    within('#pet_found') do
      expect(page).to have_content('Bowow')
      expect(page).to have_button('Add to Application')
    end
  end

  describe 'when i have added at least one pet to an application' do
    before :each do
      @dog_homes = Shelter.create!(name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
      @app_1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'New York',
                                        state: 'NY', zipcode: 10_001)
      @app_2 = Application.create!(name: 'Jane Doe', street_address: '456 Main St', city: 'Boston',
                                          state: 'MA', zipcode: 10_002)
      @roofus = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: @dog_homes.id)
      @bowow = Pet.create!(name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: @dog_homes.id)
      @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @roofus.id)
      visit "applications/#{@app_1.id}"
    end
    
    it 'i see a section to input why I want to adopt' do
      
      within('#app_information') do
        expect(page).to have_content('Roofus')
      end

      expect(page).to have_content('Please fill in why you want to adopt:')
      expect(page).to have_button('Submit Application')
    end

    describe 'When I click on Submit Application' do
      before :each do
        @dog_homes = Shelter.create!(name: 'Dog Homes', city: 'Miami', rank: 1, foster_program: true)
        @app_1 = Application.create!(name: 'John Doe', street_address: '123 Main St', city: 'New York',
                                    state: 'NY', zipcode: 10_001)
        @app_2 = Application.create!(name: 'Jane Doe', street_address: '456 Main St', city: 'Boston',
                                    state: 'MA', zipcode: 10_002)
        @roofus = Pet.create!(name: 'Roofus', age: 2, breed: 'pit bull', adoptable: true, shelter_id: @dog_homes.id)
        @bowow = Pet.create!(name: 'Bowow', age: 3, breed: 'labrador', adoptable: true, shelter_id: @dog_homes.id)
        @pet_application_1 = PetApplication.create!(application_id: @app_1.id, pet_id: @roofus.id)
        visit "applications/#{@app_1.id}"     
      end
      it 'updates the application description with text_area text' do
        within('#application_description') do
          fill_in 'description', with: 'I like dogs'
          click_on 'Submit Application'
        end
        expect(page).to have_content('Description: I like dogs')
      end
      it 'and I no longer see Add Pet to Application or search bar' do
        within('#application_description') do
          fill_in 'description', with: 'I like dogs'
          click_on 'Submit Application'
        end
        expect(page).to_not have_content('Add a Pet to this Application')
        expect(page).to_not have_content('Search name')
        expect(page).to_not have_button('Search')
      end
      it 'and it shows me the pet details for all pets on my application' do
        within('#application_description') do
          fill_in 'description', with: 'I like dogs'
          click_on 'Submit Application'
        end
        within('#application_pets') do
          # save_and_open_page
          expect(page).to have_content(@roofus.name)
          expect(page).to have_content(@roofus.age)
          expect(page).to have_content(@roofus.breed)
        end
      end
    end
  end
end
