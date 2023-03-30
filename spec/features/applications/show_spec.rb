require 'rails_helper'

RSpec.describe 'application show page' do
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


    it 'displays application information' do
      visit "/applications/#{application_1.id}"

      expect(page).to have_content(application_1.name)
      expect(page).to have_content(application_1.street_address)
      expect(page).to have_content(application_1.city)
      expect(page).to have_content(application_1.state)
      expect(page).to have_content(application_1.zip_code)
      expect(page).to have_content(application_1.description)
      expect(page).to have_content(application_1.names_of_pets)
      expect(page).to have_content(application_1.application_status)
    end
end