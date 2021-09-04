require 'rails_helper'

RSpec.describe 'Applications index page' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @app_1 = Application.create!(name: "Erika Kischuk", address: "455 Villa Ct. Morrison, CO 80228", description: "I love animals", status: "In Progress")
    @app_2 = Application.create!(name: "Kate Hill", address: "67 S Montgomery St. Lakewood, CO 80227", description: "Dogs love me!", status: "In Progress")
  end

  it 'should display all applicant names' do
    visit '/applications'

    within("#application-#{@app_1.id}") do
      expect(page).to have_content(@app_1.name)
      expect(page).to have_content(@app_1.status)
    end

    within("#application-#{@app_2.id}") do
      expect(page).to have_content(@app_2.name)
      expect(page).to have_content(@app_2.status)
    end
  end

  it 'each name should link to show page' do
    visit '/applications'

    within("#application-#{@app_1.id}") do
      click_on "#{@app_1.name}"
      expect(current_path).to eq("/applications/#{@app_1.id}")
    end

    visit '/applications'

    within("#application-#{@app_2.id}") do
      click_on "#{@app_2.name}"
      expect(current_path).to eq("/applications/#{@app_2.id}")
    end
  end
end
