require 'rails_helper'

RSpec.describe 'The application show page' do
  it 'displays all of the attributes of an application, and all the pets the application is for' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create!(name: "Jimbo Kepler", 
                                      address: "000 Street Name",
                                      city: "City Name",
                                      state: "STATE",
                                      zipcode: 00000, 
                                      description: "I love animals and they love me!", 
                                      status: "In Progress")
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    PetApplication.create!(pet: pet_1, application: application)
    PetApplication.create!(pet: pet_2, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_link(pet_1.name)
    expect(page).to have_link(pet_2.name)
  end

end