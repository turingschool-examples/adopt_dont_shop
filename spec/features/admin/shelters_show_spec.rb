require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists the shelter name and full address' do
    visit "admin/shelters/#{@shelter_1.id}"


    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.city)
  end

  it 'lists the shelter average adoptable pet age' do
    visit "admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.average_adoptable_pet_age)
  end

  it 'lists the adoptable pet count' do
    visit "admin/shelters/#{@shelter_1.id}"
    expect(page).to have_content(@shelter_1.adoptable_pet_count)
  end

  it 'lists the adopted pet count' do
    visit "admin/shelters/#{@shelter_1.id}"

    

    expect(page).to have_content(@shelter_1.adopted_pet_count)
  end
end
