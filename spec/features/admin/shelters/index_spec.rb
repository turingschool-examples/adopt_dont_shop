require 'rails_helper'

RSpec.describe 'admin shelters index' do
  describe 'all shelters' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      visit admin_shelters_path
    end

    it 'has the shelters in reverse alphabetical order' do
      expect('RGV animal shelter').to appear_before('Fancy pets of Colorado', only_text: true)
      expect('Fancy pets of Colorado').to appear_before('Aurora shelter', only_text: true)
    end
  end
end
