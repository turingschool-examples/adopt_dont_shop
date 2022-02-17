require 'rails_helper'

 RSpec.describe 'admin index' do
   it "can display admin shelters in descending order" do
     shelter_1 = Shelter.create(name: 'El Dorado Shelter', city: 'Albuquerque, NM', foster_program: false, rank: 9)
     shelter_2 = Shelter.create(name: 'Sandia Shelter', city: 'Albuquerque, NM', foster_program: true, rank: 7)
     shelter_3 = Shelter.create(name: 'La Cueva Shelter', city: 'Denver, CO', foster_program: false, rank: 2)
     shelter_4 = Shelter.create(name: 'Oakmont Shelter', city: 'New York, NY', foster_program: true, rank: 8)

     visit '/admin/shelters'

     expect(shelter_3.name).to appear_before(shelter_1.name)
   end
 end
