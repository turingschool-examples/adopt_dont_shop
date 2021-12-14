require 'rails_helper'
describe 'Admin/shelter/index page' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

  end
  it 'I see all shelters listed in reverse alphabetical order' do
    visit '/admin/shelters'
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end
  describe '#pending_applications' do
    it 'lists the name of every shelter with pending applications' do
      @application_1 = Application.create!(name:'Seth', address: '123 test st', city: 'Denver', state: 'Colorado', zip: '22835', description: 'Hello', status: 'Pending')
      @application_2 = Application.create!(name:'John', address: '123 test st', city: 'Denver', state: 'Colorado', zip: '22835', description: 'Bye', status: 'Pending')
      @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)
      visit '/admin/shelters'
      
      expect(page).to have_content("Shelters with pending applications: #{@shelter_1.name} #{@shelter_3.name}")
    end
  end
end
