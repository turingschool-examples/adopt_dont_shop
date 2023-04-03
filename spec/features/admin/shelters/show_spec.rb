require 'rails_helper'

RSpec.describe 'admin shelters show', type: :feature do
  let!(:shelter_1) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let!(:shelter_3) { Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }

  let!(:pet_1) { Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id) }
  let!(:pet_2) { Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id) }
  let!(:pet_3) { Pet.create!(adoptable: false, age: 2, breed: 'shorthair', name: 'Clawdia', shelter_id: shelter_1.id) }

  describe 'As a visitor, when I visit the admin shelter show page' do
    it 'I see the shelters name and city' do
      visit "/admin/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.city)

      visit "/admin/shelters/#{shelter_2.id}"

      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(shelter_2.city)
    end

    it 'I see a statistics section with Average Pet Age, Number of Adoptable pets and Number of Pets adopted listed' do
      visit "/admin/shelters/#{shelter_1.id}"
require 'pry'; binding.pry
      expect(page).to have_content('Statistics')
      expect(page).to have_content("Average Pet Age: 2")
      expect(page).to have_content("Number of Adoptable Pets: 2")
      expect(page).to have_content("Number of Pets Adopted: 1")
    end
  end
end