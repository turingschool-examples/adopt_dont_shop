require 'rails_helper'

RSpec.describe 'application new page', type: :feature do
  describe 'As a visitor' do

    before :each do
      @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @pet1 = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @pet2 = @shelter.pets.create!(name: "Floofy", adoptable: true, age: 7, breed: "mixed breed")
      @pet3 = @shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")
      @application1 = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
    end

    it 'I expect to see a form to fill out with 8 fields' do
      
      visit "/applications/new"

      expect(page).to have_content("First Name:")
      expect(page).to have_content("Last Name:")
      expect(page).to have_content("Address:")
      expect(page).to have_content("City:")
      expect(page).to have_content("State:")
      expect(page).to have_content("Zip Code:")
      expect(page).to have_content("Description")
      expect(page).to have_content("Status:")

    end

    xit 'I can fill in the form & I am taken to the show page where I see my information' do
      visit "/applications/new"

      fill_in('First Name:', with: "Penny")
      fill_in('Last Name:', with: "Smith")
      fill_in('Address:', with: "182 Stuart Street" )
      fill_in('City:', with: 'Baton Rouge')
      fill_in('State:', with: 'CO')
      fill_in('Zip Code:', with: 10243)
      fill_in('Description', with: "I would really like this animal, please please!")
      fill_in('Status:', with: "In Progress")

      click_on('Apply for Pet')
      
      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content("Penny")
      expect(page).to have_content("Smith")
      expect(page).to have_content("182 Stuart Street")
      expect(page).to have_content("Baton Rouge")
      expect(page).to have_content("CO")
      expect(page).to have_content("10243")
      expect(page).to have_content("I would really like this animal, please please!")
      expect(page).to have_content("In Progress")
      
    end

    xit 'If I do not fill out a field & click submit I am taking to the new app page & I see a message that I must fill in those fields' do
      visit "/applications/new"

      fill_in('First Name:', with: "Penny")
      fill_in('Last Name:', with: "Smith")
      fill_in('Address:', with: "182 Stuart Street" )
      fill_in('City:', with: 'Baton Rouge')
      fill_in('State:', with: 'CO')
      fill_in('Zip Code:', with: 10243)
      fill_in('Description', with: "I would really like this animal, please please!")

      click_on('Apply for Pet')
      
      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("You must fill in the missing information before proceeding.")
    end

  
  end
end
