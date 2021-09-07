require 'rails_helper'

RSpec.describe 'Admin shelters index page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = Pet.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter: @shelter_1)
    @pet_2 = Pet.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter: @shelter_1)
    @pet_3 = Pet.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter: @shelter_2)
    @shelter_1.pets << @pet_1
    @shelter_1.pets << @pet_2
    @shelter_3.pets << @pet_3
    @app_1 = Application.create!(name: "Erika Kischuk", address: "455 Villa Ct. Morrison, CO 80228", description: "I love animals", status: "Pending")
    @app_2 = Application.create!(name: "Kate Hill", address: "67 S Montgomery St. Lakewood, CO 80227", description: "Dogs love me!", status: "In Progress")
  end

  it 'shows all shelter names' do
    visit '/admin/shelters'

    within("#shelters-all") do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_content(@shelter_3.name)

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end

  it 'shows shelters with pending applications' do
    @app_1.pets << @pet_1
    @app_2.pets << @pet_2

    visit '/admin/shelters'

    within("#shelters-pending") do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
    end
  end
end
