require 'rails_helper'

RSpec.describe 'the pets index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)


    @application_1 = Application.create(name: 'Alexander Brueck',
                                        street_address: "16360 W Ellsworth Ave",
                                        city: "Golden",
                                        state: 'CO',
                                        zip_code: 80401,
                                        description: 'Big yard, no kids',
                                        status: 'Accepted')

    @application_2 = Application.create(name: 'Melissa Yang',
                                        street_address: "7845 First Street",
                                        city: "San Francisco",
                                        state: 'CA',
                                        zip_code: 89546,
                                        description: 'I love dogs. No kids',
                                        status: 'Pending')

    @application_3 = Application.create(name: 'Charles Dickens',
                                        street_address: "16 Washington Ave",
                                        city: "Newark",
                                        state: 'NJ',
                                        zip_code: 78291,
                                        status: 'In Progress')

    @application_4 = Application.create(name: 'Kevin McCalister',
                                        street_address: "16 First Ave",
                                        city: "New York",
                                        state: 'NY',
                                        zip_code: 56783,
                                        description: 'My kids want a dog.',
                                        status: 'Rejected')

    @pet_application_1 = PetApplication.create!(pet: @pet_1, application: @application_1)
    @pet_application_2 = PetApplication.create!(pet: @pet_2, application: @application_1)
    @pet_application_3 = PetApplication.create!(pet: @pet_3, application: @application_1)
    @pet_application_4 = PetApplication.create!(pet: @pet_3, application: @application_2)
    @pet_application_5 = PetApplication.create!(pet: @pet_2, application: @application_3)
    @pet_application_6 = PetApplication.create!(pet: @pet_1, application: @application_4)
    @pet_application_7 = PetApplication.create!(pet: @pet_1, application: @application_4)
  end


  it 'lists all the applications with their attributes' do
    visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.street_address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip_code)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
  end

#   it 'only lists adoptable pets' do
#     shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
#     pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
#     pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)
#
#     visit "/pets"
#
#     expect(page).to_not have_content(pet_3.name)
#   end
#
#   it 'displays a link to edit each pet' do
#     shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
#     pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
#
#     visit '/pets'
#
#     expect(page).to have_content("Edit #{pet_1.name}")
#     expect(page).to have_content("Edit #{pet_2.name}")
#
#     click_link("Edit #{pet_1.name}")
#
#     expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
#   end
#
#   it 'displays a link to delete each pet' do
#     shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
#     pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
#
#     visit '/pets'
#
#     expect(page).to have_content("Delete #{pet_1.name}")
#     expect(page).to have_content("Delete #{pet_2.name}")
#
#     click_link("Delete #{pet_1.name}")
#
#     expect(page).to have_current_path("/pets")
#     expect(page).to_not have_content(pet_1.name)
#   end
#
#   it 'has a text box to filter results by keyword' do
#     visit "/pets"
#     expect(page).to have_button("Search")
#   end
#
#   it 'lists partial matches as search results' do
#     shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
#     pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
#     pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
#     pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
#
#     visit "/pets"
#
#     fill_in 'Search', with: "Ba"
#     click_on("Search")
#
#     expect(page).to have_content(pet_1.name)
#     expect(page).to have_content(pet_2.name)
#     expect(page).to_not have_content(pet_3.name)
#   end
end
