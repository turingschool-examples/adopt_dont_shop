require 'rails_helper'

RSpec.describe Shelter, type: :feature do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application2 = Application.create(name: 'Caden', street_address: '111 First Street', city: 'Denver', state: 'CO', zipcode: '07321', status: 'Pending')
    @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004")

    @petapplication1 = PetApplication.create(pet_id: "#{@pet_1.id}", application_id: "#{@application1.id}")
    @petapplication2 = PetApplication.create(pet_id: "#{@pet_2.id}", application_id: "#{@application2.id}")
  end

  it 'displays the shelters by their name in reverse alphabetical order' do
    visit '/admin/shelters'

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
    # expect(Shelter.order_by_name.to_a).to eq([@shelter_2, @shelter_3, @shelter_1])
  end

  it 'as a section which displays all shelters with pending applications' do
    visit 'admin/shelters'

    within("#pendings") do
      expect(page).to have_content("RGV animal shelter")
      expect(page).to_not have_content("Aurora shelter")
    end
  end
end