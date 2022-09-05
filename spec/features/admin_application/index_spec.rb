require 'rails_helper'

RSpec.describe 'Admin Shelters index' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Humane Society', city: 'Englewood', foster_program: false, rank: 8)
    @shelter_2 = Shelter.create(name: 'Family Tree House', city: 'Englewood', foster_program: false, rank: 4)
    @shelter_3 = Shelter.create(name: 'Life is Better Rescue', city: 'Lakewood', foster_program: true, rank: 1)
    @shelter_1.pets.create(name: 'Jimmy Jam', breed: 'dog', age: 3, adoptable: true)
    @shelter_1.pets.create(name: 'Janet', breed: 'cat', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lickity Splits', breed: 'llama', age: 5, adoptable: true)
  end

  it 'is able to go to admin/shelters and see all shelters listed in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(@shelter_3.name).to appear_before(@shelter_2.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
  end

  it 'can display all pending applications' do
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    @application = Application.create!(name: 'John Stamos', street_address: '63254 Random', city: "MadeUp", state: 'CA', zip_code: 65432, description: 'because Im famous', status: "Pending" )
    @application_2 = Application.create!(name: 'Jack Stamos', street_address: '4 Random', city: "MadeUp", state: 'CA', zip_code: 65432, description: 'because Im not famous', status: "In Progress" )
    PetApplication.create!(application: @application, pet: @pet_1)
    PetApplication.create!(application: @application_2, pet: @pet_3)

    visit 'admin/shelters'

    within '#pending' do
      expect(page).to have_content('Humane Society')
      expect(page).to_not have_content('Life is Better Rescue')
    end
  end
end