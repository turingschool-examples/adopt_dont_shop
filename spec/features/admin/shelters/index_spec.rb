require 'rails_helper'

RSpec.describe 'admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'lists shelter names by name reverse alphabetical order by default' do
    visit "/admin/shelters"

    first = find("#shelter-#{@shelter_2.id}")
    second = find("#shelter-#{@shelter_3.id}")
    third = find("#shelter-#{@shelter_1.id}")

    expect(first).to appear_before(second)
    expect(second).to appear_before(third)
  end
end
