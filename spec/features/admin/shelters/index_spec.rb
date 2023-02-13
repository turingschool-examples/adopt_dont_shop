require 'rails_helper'

describe 'As a visitor' do
  describe "When I visit the admin shelter index ('/admin/shelters')" do
    let!(:shelter_1) {Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
    let!(:shelter_2) {Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)}
    let!(:shelter_3) {Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}

    it 'I see all Shelters in the system listed in reverse alphabetical order by name' do
      visit '/admin/shelters'
      expect(page).to have_content('Aurora shelter')
      expect(page).to have_content('RGV animal shelter')
      expect(page).to have_content('Fancy pets of Colorado')

      expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
      expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    end
  end
end