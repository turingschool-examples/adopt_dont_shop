require 'rails_helper'

RSpec.describe 'admin/applications'do
  describe 'as a visitor when I visit the admin applications show page' do
    before(:each) do
    @shelter_1 = Shelter.create!(name: 'SF shelter', city: 'Santa Fe, NM', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Burora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create!(name: 'Curora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Pinhead', breed: 'guinea pig', age: 1, adoptable: true)
    @pet_5 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'ZZZ', shelter_id: @shelter_1.id)
    @pet_7 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Rufus', shelter_id: @shelter_2.id)
    @app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
    @app_2 = Application.create!(name: 'Franklin', address: '611 Wallow Ct', city: 'Santa Fe', state: 'NM', zip: '87508', description: 'Lonely guy with hella money', status: "In Progress")

    PetApplication.create!(application: @app_2, pet: @pet_7)
    end

    it 'has approve button for each pet' do
      visit "/admin/applications/#{@app_2.id}"
      save_and_open_page
      expect(page).to have_content('Approve Application')
      expect(page).to have_content(@pet_7.name)
    end

    it 'can approve application' do
      visit "/admin/applications/#{@app_2.id}"
      click_on 'Approve Application'
      expect(page).to have_content('Approved')
      expect(page).to have_content(@pet_7.name)
      expect(page).to have_no_content('Approve Application')
    end
  end
end