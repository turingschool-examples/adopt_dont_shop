require 'rails_helper'

RSpec.describe 'Application show page' do
  it 'shows the application and its attributes' do
    application = Application.create!(name: 'Chris P. Bacon', street_address: '123 Main Street', city: 'Anytown', state: 'CO', zip_code: 12345, description: 'I like pets', status: 'Pending')
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    application.pets << pet_1
    application.pets << pet_2
    application.pets << pet_3

    visit "/applications/#{application.id}"

    within("#application-#{application.id}") do
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.full_address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.status)
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_3.name)
      expect(page).to have_link(nil, href: "/pets/#{pet_1.id}")
      expect(page).to have_link(nil, href: "/pets/#{pet_2.id}")
      expect(page).to have_link(nil, href: "/pets/#{pet_3.id}")
    end
  end

  describe 'Add a Pet to this Application' do
    it 'has a section to search for pets' do
      application = Application.create!(name: 'Chris P. Bacon', street_address: '123 Main Street', city: 'Anytown', state: 'CO', zip_code: 12345, description: 'I like pets', status: 'Pending')

      visit "/applications/#{application.id}"

      within('#pet_search') do
        expect(page).to have_content('Add a Pet to this Application')
      end
    end
    it 'shows the pets with names that match the search' do
      application = Application.create!(name: 'Chris P. Bacon', street_address: '123 Main Street', city: 'Anytown', state: 'CO', zip_code: 12345, description: 'I like pets', status: 'Pending')
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)

      visit "/applications/#{application.id}"
      fill_in 'Search', with: 'Ann'

      click_button 'Search'

      within("#application-#{application.id}") do
        expect(page).to have_content(application.name)
      end
      within('#pet_search') do
        expect(page).to have_content(pet_3.name)
      end
    end
    it 'shows the pets with names that partially match the search' do
      application = Application.create!(name: 'Chris P. Bacon', street_address: '123 Main Street', city: 'Anytown', state: 'CO', zip_code: 12345, description: 'I like pets', status: 'Pending')
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      pet_3 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      pet_4 = shelter_1.pets.create(name: 'Another Pet', breed: 'ragdoll', age: 3, adoptable: false)

      visit "/applications/#{application.id}"
      fill_in 'Search', with: 'An'

      click_button 'Search'

      within("#application-#{application.id}") do
        expect(page).to have_content(application.name)
      end
      within('#pet_search') do
        expect(page).to have_content(pet_3.name)
        expect(page).to have_content(pet_4.name)
      end
      visit "/applications/#{application.id}"
      fill_in 'Search', with: 'an'

      click_button 'Search'

      within("#application-#{application.id}") do
        expect(page).to have_content(application.name)
      end
      within('#pet_search') do
        expect(page).to have_content(pet_3.name)
        expect(page).to have_content(pet_4.name)
      end
    end
  end
end