require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  describe 'When I visit the admin shelter index' do
    describe "I see all shelters in the system listed in reverse alphabetical order by name" do
      it 'sorts shelters in reverse alphabetical order by name' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        
        visit "/admin/shelters"
        
        expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
        expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
        expect('Aurora shelter').to_not appear_before('RGV animal shelter')        
      end
    end
  end
end