require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    # @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    # @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists all the shelter names in reverse alpha order' do
    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end

  it 'shows shelters w/ pending applications inside the pending app section' do
    @app = Application.create(name: "John Smith", address: "123 Main St, Denver, CO, 80120", about: "I love a dogs. One please.", status: "Pending")
    ApplicationPet.create!(application_id: @app.id, pet_id: @pet_1.id)
    
    visit "/admin/shelters"

    within "#shelters_w_pending_apps" do
      expect(page).to have_content(@shelter_1.name)
    end
  end
end