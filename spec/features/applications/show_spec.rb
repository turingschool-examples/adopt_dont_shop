require 'rails_helper'

RSpec.describe 'visit application show page' do
    let!(:shelter_1)  { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
    let!(:shelter_2)  { Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
    let!(:shelter_3)  { Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }

    let!(:pet_1) { shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true) }
    let!(:pet_2) { shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true) }
    let!(:pet_3) { shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true) }
    let!(:pet_4) { shelter_1.pets.create!(name: 'Ms. Pirate', breed: 'tuxedo shorthair', age: 8, adoptable: true) }

    let!(:app_1) { Application.create!(name: 'Steve', 
                                street: '152 Steve St.', 
                                city: 'Denver', 
                                state: 'CO', 
                                zip: '40208', 
                                desc: "I'm nice.", 
                                status: 'Pending') }
    
    # let!(:pet_app_1) {PetApplication.create!(pet_id: pet_1.id, application_id: app_1.id)}

  describe 'application show' do
    it 'it shows the application attributes' do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.name)
      expect(page).to have_content(app_1.street)
      expect(page).to have_content(app_1.city)
      expect(page).to have_content(app_1.state)
      expect(page).to have_content(app_1.zip)
      expect(page).to have_content(app_1.desc)
      expect(page).to have_content(app_1.status)
    end
  end

	describe 'application in progress, add pets' do
		it 'has an add pets field and button' do
			visit "/applications/#{app_1.id}"

			expect(page).to have_field('Add a Pet to this Application')
			expect(page).to have_button('Search Pets')
		end

		it 'when I fill out field and click Search Pet, I am taken back to show page' do
			visit "/applications/#{app_1.id}"

			fill_in 'pet_name', with: 'Mr. Pirate'
			click_button

			expect(current_path).to eq("/applications/#{app_1.id}")
		end

		it 'shows all pets with search value under search field' do
			visit "/applications/#{app_1.id}"

			fill_in 'pet_name', with: 'Pirate'
			click_button

			expect(page).to have_content(pet_1.name)
			expect(page).to have_content(pet_4.name)
		end

    it 'has a button to adopt pet' do
      visit "/applications/#{app_1.id}"
      
      fill_in 'pet_name', with: 'Pirate'
			click_button

      expect(page).to have_button("Adopt #{pet_1.name}")
      click_button("Adopt #{pet_1.name}")

      expect(current_path).to eq("/applications/#{app_1.id}")
      expect(page).to have_content("#{pet_1.name}")
    end
	end
end