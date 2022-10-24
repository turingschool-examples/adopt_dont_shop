require 'rails_helper'

RSpec.describe "AdminShelters" do 
  describe 'rev alpha-US 10' do 
    it 'uses raw sql to list shelter names reverse alphabetically' do 
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      expect(Shelter.rev_alpha).to eq([shelter_2, shelter_3, shelter_1])
    end
  end
end