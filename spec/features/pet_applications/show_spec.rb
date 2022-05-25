require 'rails_helper'

RSpec.describe PetApplication, type: :feature do
  context "create new" do
    before(:each) do
      @shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
      @pet11 = @shelter1.pets.create(name: 'Mr. Biggs', age: 2, breed: 'Great Dane', adoptable: true)
      @pet12 = @shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
      @pet13 = @shelter1.pets.create(name: 'Carter', age: 7, breed: 'Golden Retriever', adoptable: true)
      @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004")
      @petapplication1 = PetApplication.create(pet_id: "#{@pet11.id}", application_id: "#{@application1.id}")
    end

    it 'creates a new petapplication and redirects to application show page' do
      visit "/applications/#{@application1.id}"
      fill_in 'Search', with: 'Spike'
      click_on('Search')
      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content('Spike')

      click_on 'Adopt this Pet'
      expect(current_path).to eq("/applications/#{@application1.id}")

      within '#current_pets' do
        expect(page).to have_content('Spike')
      end
    end
  end

  describe "submit application" do
    before(:each) do
      @shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
      @pet12 = @shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
      @pet11 = @shelter1.pets.create(name: 'Mr. Biggs', age: 2, breed: 'Great Dane', adoptable: true)
      @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004")
    end

    it "button is present if it has pets and description" do
      visit "/applications/#{@application1.id}"
      expect(@application1.status).to eq("In Progress")

      expect(page).to_not have_button("Submit my Application")
      fill_in 'Search', with: 'Spike'
      click_on 'Search'

      click_on 'Adopt this Pet'
      # fill_in :description with "Because"

      expect(page).to have_button('Submit My Application')
      expect(page).to have_content("In Progress")
    end

    it "routes back to the application show page once the application is submitted with pets" do
      visit "/applications/#{@application1.id}"
      fill_in 'Search', with: 'Spike'
      click_on 'Search'
      click_on 'Adopt this Pet'

      fill_in 'Search', with: 'Mr. Biggs'
      click_on 'Search'

      click_on 'Adopt this Pet'
      # fill_in :description with "Because"

      click_on 'Submit My Application'
      
      expect(page).to_not have_button('Submit my Application')
      expect(page).to have_content("Pending")
    end
  end
end
