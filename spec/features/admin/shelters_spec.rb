require 'rails_helper'

RSpec.describe 'admin/shelters'do
  describe 'as a visitor when I visit the admin shelters index page' do
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

    it 'displays all shelters in reverse alphabetical order by name' do
      visit '/admin/shelters'

      expect(@shelter_1.name).to appear_before(@shelter_2.name)
      expect(@shelter_3.name).to appear_before(@shelter_2.name)
    end

    it 'displays a section for shelters w pending applications' do
      visit "/applications/#{@app_1.id}"

      fill_in 'pet_name', with: 'ZZZ'
      click_on 'Search'
      click_on 'Adopt this pet'

      visit 'admin/shelters'

      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content(@shelter_1.name, count: 2)
    end
  end
end