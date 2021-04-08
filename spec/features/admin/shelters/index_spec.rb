require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create(name: 'Rolf o Rama', city: 'Arfvada, CO', foster_program: true, rank: 6)

    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @shelter_4.pets.create(name: 'Barkley', breed: 'muppet', age: 42, adoptable: true)

    visit "/admin/shelters"
  end

  it 'lists all the shelter names' do
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
    expect(page).to have_content(@shelter_4.name)
  end


  describe "As a visitor, when I visit the admin shelter index\
    ('/admin/shelters')" do
    it "I see all Shelters in the system listed in reverse alphabetical order\
       by name" do

      expect(@shelter_4.name).to appear_before(@shelter_2.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end
end
