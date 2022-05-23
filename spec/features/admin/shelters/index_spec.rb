require 'rails_helper'

describe 'the admin application show page', type: :feature do
  let!(:shelter_1) {Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:shelter_2) {Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)}
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
  let!(:pet_1) {Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)}
  let!(:app_1) {Application.create(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303)}
  let!(:pet_application_1) {PetApplication.create(pet_id: pet_1.id, application_id: app_1.id)}


  it "lists all shelters in reverse alphabetical order" do
    visit '/admin/shelters'

    expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
  end

  describe 'shelters with pending applications' do
    it 'displays a section for Shelters with Pending Applications' do
      app_1.status = 'Pending'
      app_1.save
      visit '/admin/shelters'

      within "#pending-shelters" do
        expect(page).to have_content("Aurora shelter")
        expect(page).to_not have_content("RGV animal shelter")
        expect(page).to_not have_content("Fancy pets of Colorado")
      end
    end
  end
end
