require 'rails_helper'

 RSpec.describe 'applications show page' do

   it "displays applicant attributes" do
     application_1 = Application.create(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'Approved')
     shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
     pet_1 = Pet.create(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: shelter_1.id)
     pet_2 = Pet.create(name: 'Gibblets', breed: 'French Bulldog', age: 3, adoptable: true, shelter_id: shelter_1.id)
     PetApplication.create(pet: pet_1, application: application_1)

     visit "/applications/#{application_1.id}"
     # save_and_open_page

     expect(page).to have_content(application_1.name)
     expect(page).to have_content(application_1.address)
     expect(page).to have_content(application_1.city)
     expect(page).to have_content(application_1.state)
     expect(page).to have_content(application_1.zipcode)
     expect(page).to have_content(application_1.description)
     expect(page).to have_content(application_1.status)
   end
 end
