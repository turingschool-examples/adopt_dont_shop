require 'rails_helper'

RSpec.describe 'application creation' do
  let!(:application_1) { Application.create!(name: 'Bob', street_address: '1234 Southeast St',
                                            city: 'San Francisco', state: 'CA', zip_code: 12345,
                                            description: 'Wants a dog', names_of_pets: 'Fluffy', application_status: 'Pending') }

  let!(:application_2) { Application.create!(name: 'Sally', street_address: '4321 Bridge Way',
                                            city: 'San Francisco', state: 'CA', zip_code: 54321,
                                            description: 'Would like a siamese cat', names_of_pets: 'Coz', application_status: 'In Progress') }

  let!(:application_3) { Application.create!(name: 'Fred', street_address: '376 Monroe St',
                                            city: 'Los Angeles', state: 'CA', zip_code: 67890,
                                            description: 'Interested in sibling pets', names_of_pets: 'Jack, Jill', application_status: 'Accepted') }

  let!(:application_4) { Application.create!(name: 'Jane', street_address: '74026 Deep South St',
                                            city: 'San Diego', state: 'CA', zip_code: 92056,
                                            description: 'Doesnt like animals', names_of_pets: 'Mittens', application_status: 'Rejected') }
                                    
    it 'links to a new page for application form from pet index' do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      visit '/pets'

      click_link("Start an Application for #{pet_1.name}")

      expect(current_path).to eq("/pets/#{pet_1.id}/applications/new")
    end

    it 'can create new application for future pet owner' do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      visit "/pets/#{pet_1.id}/applications/new"

      fill_in(:name, with: 'Bob')
      fill_in(:street_address, with: '1234 Southeast St')
      fill_in(:city, with: 'San Francisco')
      fill_in(:state, with: 'CA')
      fill_in(:zip_code, with: 12345)
      fill_in(:description, with: 'Wants a dog')
      click_button('Submit Application')

      expect(current_path).to eq("/applications/#{application_2.id}")
    end
end