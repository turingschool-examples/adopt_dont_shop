require 'rails_helper'

RSpec.describe 'the admin shelters index page' do 
  describe 'when a visitor visits the index page' do 
    it 'has the names of all shelters listed in reverse alphabetical order' do 
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  
      visit '/admin/shelters'

      expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
      expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    end
  end 
end 