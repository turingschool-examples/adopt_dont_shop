require 'rails_helper'

RSpec.describe 'starting an application' do
  before(:each) do
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(name: 'Indy', age: 4, breed: 'Mutt', adoptable: true, shelter_id: @shelter.id)
  end

  describe 'As a user when I visit the pet index page' do
    it 'I see a link to create a new application' do
      visit '/pets'

      expect(page). to have_link("Start an Application", href: "/applications/new" )
    end

    it 'brings me to a new submission from' do
      visit '/pets'

      click_link("Start an Application")

      expect(current_path).to eq('/applications/new')
    end

    it 'can create a new application and redirects to the application show page' do
      
      visit '/applications/new'

      fill_in('First Name', with: 'Jon')
      fill_in('Last Name', with: 'Duttko')
      fill_in('Street Address', with: '1018 O Street NW')
      fill_in('City', with: 'Washington')
      fill_in('State', with: 'DC')
      fill_in('Zip Code', with: 20001)
      click_button('Create Application')

      expect(current_path).to eq("/applications/#{Application.last.id}")

      expect(page).to have_content("Jon")
      expect(page).to have_content("DC")
      expect(page).to have_content("In Progress")
    end

    it 'cannot create a new application without filling in all form fields' do
      visit '/applications/new'
      fill_in('First Name', with: 'Jon')
      fill_in('Last Name', with: 'Duttko')
      fill_in('Street Address', with: '1018 O Street NW')
      fill_in('City', with: 'Washington')
      fill_in('State', with: 'DC')
      click_button('Create Application')

      expect(current_path).to eq("/applications")
      expect(page).to have_content("New Application")
      expect(page).to have_button("Create Application")
      expect(page).to have_content("Application not created: Required information missing.")
    end


  end
  describe 'when I have created my application' do
    it 'I see a section on a page to add a pet to this application' do
      visit '/applications/new'

        fill_in('First Name', with: 'Jon')
        fill_in('Last Name', with: 'Duttko')
        fill_in('Street Address', with: '1018 O Street NW')
        fill_in('City', with: 'Washington')
        fill_in('State', with: 'DC')
        fill_in('Zip Code', with: '20001')
        click_button('Create Application')

      expect(page).to have_content("Add a Pet")

      fill_in("search", with: "Indy")
      click_on("Search Pets")

      expect(current_path).to eq("/applications/#{Application.last.id}")

      expect(page).to have_content("Indy")

      expect(page).to_not have_content("Scooby")
    end

    it 'I see a link to adopt each pet' do
      visit '/applications/new'

        fill_in('First Name', with: 'Jon')
        fill_in('Last Name', with: 'Duttko')
        fill_in('Street Address', with: '1018 O Street NW')
        fill_in('City', with: 'Washington')
        fill_in('State', with: 'DC')
        fill_in('Zip Code', with: '20001')
        click_button('Create Application')

      expect(page).to have_content("Add a Pet")

      fill_in("search", with: "Indy")
      click_on("Search Pets")

      expect(page).to have_button("Adopt #{@pet_2.name}")

      click_button("Adopt #{@pet_2.name}")

      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content("Indy")
      expect(page).to_not have_content("Scooby")
    end
  end
end