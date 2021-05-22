require 'rails_helper'

RSpec.describe 'show page' do
  it 'can see all attributes of application' do
    # Application Show Page
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

    application_1 = Application.create!(name:'Julius Caesar',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'Pending')
    application_2 = Application.create!(name:'Test',
                                      street_address: '123 Copperfield Lane',
                                      city: 'Atlanta', state: 'GA',
                                      zip_code: '30301',
                                      description: 'I love dogs',
                                      application_status: 'Pending')
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = shelter.pets.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = shelter.pets.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    ApplicationPet.create!(pet: pet_1, application: application_1)
    ApplicationPet.create!(pet: pet_2, application: application_1)
    visit "/applications/#{application_1.id}"

    expect(page).to have_content(application_1.name)
    expect(page).to have_content(application_1.street_address)
    expect(page).to have_content(application_1.city)
    expect(page).to have_content(application_1.state)
    expect(page).to have_content(application_1.zip_code)
    expect(page).to have_content(application_1.description)
    expect(page).to have_content(application_1.application_status)
    save_and_open_page
    within("#application-#{application_1.id}") do
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
    end
  end
end
