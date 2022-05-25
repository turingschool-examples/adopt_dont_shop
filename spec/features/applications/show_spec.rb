require 'rails_helper'


RSpec.describe Application, type: :feature do
  describe 'Application Show Page' do
    context 'as a visitor, can see all parameters' do
      before(:each) do
        @shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
        @pet11 = @shelter1.pets.create(name: 'Mr. Biggs', age: 2, breed: 'Great Dane', adoptable: true)
        @pet12 = @shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
        @pet13 = @shelter1.pets.create(name: 'Carter', age: 7, breed: 'Golden Retriever', adoptable: true)
        @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004")
        @shelter2 = Shelter.create(name: 'Colorado Cats', city: 'Vail', foster_program: true, rank: 5)
        @pet21 = @shelter2.pets.create(name: 'Boots', age: 4, breed: 'Tabby', adoptable: true)
        @pet22 = @shelter2.pets.create(name: 'Evil Steve', age: 4, breed: 'Unknown', adoptable: false)
        @pet23 = @shelter2.pets.create(name: 'Huckleberry', age: 17, breed: 'Tuxedo', adoptable: true)
        @application2 = Application.create(name: 'Caden', street_address: '111 First Street', city: 'Denver', state: 'CO', zipcode: '07321')
        @petapplication1 = PetApplication.create(pet_id: "#{@pet11.id}", application_id: "#{@application1.id}")
        @petapplication2 = PetApplication.create(pet_id: "#{@pet12.id}", application_id: "#{@application1.id}")

        visit "/applications/#{@application1.id}"
      end

      it 'also shows status' do
        expect(page).to have_content('Chris')
        expect(page).to have_content('123 Main St')
        expect(page).to have_content('Hometown')
        expect(page).to have_content('CO')
        expect(page).to have_content('00004')
        within '#current_pets' do
        expect(page).to have_content('Mr. Biggs')
        expect(page).to have_content('Spike')
        expect(page).to_not have_content('Evil Steve')
        end
        expect(page).to have_content('In Progress')
      end

      it 'allows for a user to add pets to an application before submitting' do
     
        expect(page).to have_button('Search')
        fill_in 'Search', with: 'Spike'
        click_on('Search')
        expect(current_path).to eq("/applications/#{@application1.id}")
        expect(page).to have_content('Spike')
        expect(page).to_not have_content('Boots')
      end

      it 'allows for partial search matches in the search bar' do
        fill_in 'Search', with: 'ike'
        click_on('Search')
        expect(current_path).to eq("/applications/#{@application1.id}")
        expect(page).to have_content('Spike')
        expect(page).to_not have_content('Boots')
      end

      it 'allows for case insensetive mathces for the search bar' do
        fill_in 'Search', with: 'SPIKE'
        click_on('Search')
        expect(current_path).to eq("/applications/#{@application1.id}")
        expect(page).to have_content('Spike')
        expect(page).to_not have_content('Boots')
      end
    end
  end
end
