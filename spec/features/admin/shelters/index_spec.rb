require 'rails_helper'


RSpec.describe 'the admin shelter index' do
  it "shows all of the shelters in the system listed in reverse alphabetical order" do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    visit '/admin/shelters'


    expect(shelter_3.name).to appear_before(shelter_1.name)
    expect(shelter_2.name).to appear_before(shelter_3.name)
  end

  #   For this story, you should fully leverage ActiveRecord methods in your query.
  #
  # Shelters with Pending Applications
  #
  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application

  it "shows shelters with Pending Applications" do
    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    application_1 = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome', status: 'pending')
    application_2 = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome', status: 'pending')
    application_3 = Application.create!(name: 'Ted', street: '2335 south Race St.', city: 'Denver', state: 'Colorado', zip: '80210',  description: 'I am awesome', status: 'approved')
    ApplicationPet.create!(application: application_1, pet: pet_1 )
    ApplicationPet.create!(application: application_3, pet: pet_3 )

    visit '/admin/shelters'



    expect(page).to have_content("Shelter's with Pending Applications")

    within("#shelter") do
      expect(page).to have_content(shelter_1.name)
      expect(page).to_not have_content(shelter_3.name)
    end
  end
end
