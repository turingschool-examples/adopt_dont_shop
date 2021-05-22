require 'rails_helper'

RSpec.describe 'applications show page', type: :feature do
  before (:each) do
    @application1 = Application.create!(name: "Big Bird", street_address: '1311 E 27TH AVE', city: 'DENVER', state: 'CO', zip_code: 80205, statement: nil)
    shelter1 = Shelter.create!(foster_program: 'Cat Savers', name: 'Cats R Us', city: 'Denver', rank: 1)
    @pet1 = shelter1.pets.create!(adoptable: true, age: 0, breed: 'Siamese Cat', name: 'Pear')
    @pet2 = shelter1.pets.create!(adoptable: true, age: 1, breed: 'Blue Russian Cat', name: 'Oleg')
    @pet3 = shelter1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Short Hair Cat', name: 'Ralph')
  end

  describe 'default show page appearance' do
    it 'has certain fields in the Applicant Details section by default' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Applicant Details:')
      expect(page).to have_content('Application Status:')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Note - Your application has not been submitted yet!')
      expect(page).to have_content("In order to submit, you must add both 'Pets To Adopt' and an 'Adoption Statement' below.")
      expect(page).to have_content('Name:')
      expect(page).to have_content('Big Bird')
      expect(page).to have_content('Street Address:')
      expect(page).to have_content('1311 E 27TH AVE')
      expect(page).to have_content('City:')
      expect(page).to have_content('DENVER')
      expect(page).to have_content('State:')
      expect(page).to have_content('CO')
      expect(page).to have_content('Zip Code:')
      expect(page).to have_content('80205')
    end
    it 'has certain text in the Pets To Be Adopted section by default' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Pets To Be Adopted:')
      expect(page).to have_content('Please add pets to your application')
      expect(page).to have_content('Search pets by name')
      expect(page).to have_content('All Adoptable Pets:')
      expect(page).to have_content('Pear')
      expect(page).to have_content('Oleg')
      expect(page).to have_content('Ralph')
    end
    it 'has certain text in the Adoption Statement section by default' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Adoption Statement')
      expect(page).to have_content('Please add an adoption statement')
      expect(page).to have_button('Add Statement')
    end
  end
  describe 'Searching pets functionality' do
    it 'allows you to search by an exact pet name' do
      visit "/applications/#{@application1.id}"
      fill_in 'search', with: 'Pear'
      click_button('Search')

      expect(page).to have_content('Pear')
      expect(page).to_not have_content('Oleg')
    end
    it 'allows you to search by a partial pet name' do
      visit "/applications/#{@application1.id}"
      fill_in 'search', with: 'Pe'
      click_button('Search')

      expect(page).to have_content('Pear')
      expect(page).to_not have_content('Oleg')
    end
    it 'allows for case insensitive searches' do
      visit "/applications/#{@application1.id}"
      fill_in 'search', with: 'PeAr'
      click_button('Search')

      expect(page).to have_content('Pear')
      expect(page).to_not have_content('Oleg')
    end
  end
end