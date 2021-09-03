require 'rails_helper'

RSpec.describe 'admin shelters index' do
  describe 'all shelters' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      @pet1 = @shelter_1.pets.create!(name: 'Rifle', breed: 'terrier', age: 11, adoptable: true)
      @pet2 = @shelter_2.pets.create!(name: 'Snickers', breed: 'great dane', age: 13, adoptable: true)
      @pet3 = @shelter_3.pets.create!(name: 'Bailey', breed: 'great pyranese', age: 8, adoptable: true)
      @app = Application.create!(
        name: 'Tanner',
        address: '123',
        city: 'a',
        state: 'b',
        zipcode: 'a',
        reason: 'pets'
      )
      @app.pets << @pet1
      @app.pets << @pet2
      @app.set_to_pending

      visit admin_shelters_path
    end

    it 'has the shelters in reverse alphabetical order' do
      expect('RGV animal shelter').to appear_before('Fancy pets of Colorado', only_text: true)
      expect('Fancy pets of Colorado').to appear_before('Aurora shelter', only_text: true)
    end

    it 'has shelters with applications that are pending' do
      within '#pending-apps' do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_2.name)
        expect(page).not_to have_content(@shelter_3.name)
      end
    end
  end
end
