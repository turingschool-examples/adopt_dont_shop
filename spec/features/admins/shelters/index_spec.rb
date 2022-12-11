require 'rails_helper' 

RSpec.describe 'admin shelter index' do
  # before(:each) do
  #   @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
  #   @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

  #   @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
  #   @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
  #   @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  #   @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

  #   @application = @pet_1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
  # end
  
  it 'lists all shelters in reverse alphabetical order' do
    shelter1 = Shelter.create!(foster_program: true, name: "Doggie Dog World", city: "Denver", rank: 3)
    shelter2 = Shelter.create!(foster_program: true, name: "Endless Pawsabilities", city: "Durango", rank: 1)
    shelter3 = Shelter.create!(foster_program: true, name: "Tail of two Kitties", city: "Seattle", rank: 9)

    visit '/admin/shelters'

    expect(shelter3.name).to appear_before(shelter2.name)
    expect(shelter2.name).to appear_before(shelter1.name)
  end

  it 'contains a section with shelters that have pending applications' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    application = pet_1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/admin/shelters"

    within("div#pending") do
      expect(page).to have_content("Shelter's with Pending Applications")
      expect(page).to have_content('Aurora shelter')
      expect(page).to_not have_content('RGV animal shelter')
      expect(page).to_not have_content('Fancy pets of Colorado')
    end
  end
  
end