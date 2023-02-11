require 'rails_helper'

RSpec.describe 'applications show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @petition = Petition.create!(name: 'John', street_address: '1 Sesame St', city: 'Denver',
                    state: 'CO', zip_code: 12345, description: 'I like dogs', status: 'In Progress')
      @petition2 = Petition.create!(name: 'Nhoj', street_address: '2 Sesame St', city: 'Renved',
                    state: 'OC', zip_code: 54321, description: 'Dogs like I', status: 'Pending')
      @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
      @pet2 = Pet.create!(name: 'Dooby', age: 3, breed: 'Greater Dane', adoptable: true, shelter_id: @shelter.id)
      @pet3 = Pet.create!(name: 'Ruf', age: 5, breed: 'Greatest Dane', adoptable: true, shelter_id: @shelter.id)
      @pet3 = Pet.create!(name: 'Rufus', age: 2308732, breed: 'Lesser Dane', adoptable: true, shelter_id: @shelter.id)
      @pet4 = Pet.create!(name: 'Sufur', age: 230, breed: 'Less Dane', adoptable: true, shelter_id: @shelter.id)
      @petition_pet = PetitionPet.create!(petition_id: @petition.id, pet_id: @pet1.id)
    end

    it 'I can see the applications attributes' do
      visit "petitions/#{@petition.id}"
      expect(page).to have_content('John')
      expect(page).to have_content('1 Sesame St')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content(12345)
      expect(page).to have_content('I like dogs')
      expect(page).to have_content('In Progress')
    end

    it 'has names of pets as links to their show pages' do
      visit "petitions/#{@petition.id}"
      
      expect(page).to have_link('Scooby')
      # expect(page).to have_link('Dooby')

      click_link 'Scooby'

      expect(page).to have_current_path("/pets/#{@pet1.id}")
    end

    it 'I can see a section on the page to add a pet to this appliction' do
      visit "petitions/#{@petition.id}"
      # save_and_open_page
      fill_in 'search', with: 'Ruf'
      click_button 'Search'
      
      expect(page).to have_content('Ruf')
      expect(page).to have_content('Rufus')
    end

    it 'I can adopt pets' do
      visit "petitions/#{@petition.id}"

      fill_in 'search', with: 'Sufur'
      click_button 'Search'
      expect(page).to have_button('Adopt this Pet')
      save_and_open_page
      
      click_button 'Adopt this Pet'

      expect(page).to have_link('Sufur')
    end
  end
end