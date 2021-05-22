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
    # require 'pry'; binding.pry
    visit "/applications/#{application.id}"
    save_and_open_page
    within("#application-#{application.id}") do
      expect(page).to have_content(application.name)
      expect(page).to have_content(application.street_address)
      expect(page).to have_content(application.city)
      expect(page).to have_content(application.state)
      expect(page).to have_content(application.zip_code)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.status)
    end
  end
end