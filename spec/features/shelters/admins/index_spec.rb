require 'rails_helper'

RSpec.describe 'admin shelts index page' do
  it 'lists all shelters in reverse alphabetical order by name' do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    visit "/admin/shelters"
    actual = page.find_all('.shelter').map(&:text).join
    expected = [@shelter_2.name, @shelter_3.name, @shelter_1.name].join(" ")


    expect(actual).to eq(expected)
  end

  describe 'pending applications section' do
    it 'has a section for applications that are pending' do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

      derek = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 }, status: "Pending")
      jim = Application.create!(name: "Jim", description: "I love all animals", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223}, status: "Pending" )
      billy = Application.create!(name: "Derek", description: "I love dogs", address: {city: "Denver", state: "CO", street: "Kalamath", zip: 80223 }, status: "Pending")
      derek.pets << @pet_1
      jim.pets << @pet_3
      billy.pets << @pet_4

      visit "/admin/shelters"

      within ".pending-app" do
        expect(page).to have_content("Shelter's with Pending Applications")
        expect(page).to have_content(@shelter_3.name)
        expect(page).to have_content(@shelter_1.name)
      end
    end
  end
end
