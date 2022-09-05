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
end