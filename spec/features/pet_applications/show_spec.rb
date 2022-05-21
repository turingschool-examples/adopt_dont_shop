require 'rails_helper'

RSpec.describe PetApplications, type: :feature do
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
      binding.pry
      click_on 'Adopt this Pet'
      expect(current_path).to eq("/applications/#{@application1.id}")

      within '#current_pets' do
        expect(page).to have_content('Spike')
      
      end
    end
  end
end