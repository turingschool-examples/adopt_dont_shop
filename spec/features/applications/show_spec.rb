require 'rails_helper'

 RSpec.describe 'applications show page' do
   before(:each) do
     @application_1 = Application.create!(name: 'Michael Hicks', address: '4012 Tracy St NE', city: 'Albuquerque', state: 'NM', zipcode: 87111, description: 'Really REALLY good guy', status: 'Approved')
     @shelter_1 = Shelter.create!(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
     @pet_1 = Pet.create!(name: 'Queso', breed: 'Boston Terrier', age: 5, adoptable: true, shelter_id: @shelter_1.id)
   end

   it "displays applicant attributes" do
     visit "/applications/#{@application_1.id}"

     expect(page).to have_content(@application_1.name)
     expect(page).to have_content(@application_1.address)
     expect(page).to have_content(@application_1.city)
     expect(page).to have_content(@application_1.state)
     expect(page).to have_content(@application_1.zipcode)
   end
 end
