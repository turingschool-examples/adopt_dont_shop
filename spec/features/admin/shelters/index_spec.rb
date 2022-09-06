require 'rails_helper'

RSpec.describe 'the admin shelter index' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 7, breed: 'yorkie', name: 'Mr. Pig')
    @pet_3 = @shelter_2.pets.create!(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill')
    @pet_4 = @shelter_2.pets.create!(adoptable: true, age: 4, breed: 'long hair', name: 'Sweet Potato')
    @pet_5 = @shelter_3.pets.create!(adoptable: true, age: 6, breed: 'Huskey', name: 'Todd')
    @pet_6 = @shelter_3.pets.create!(adoptable: true, age: 2, breed: 'Calico', name: 'Potato Chip')

    @application_1 = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "Pending", description: "I'm Lonely")
    @application_2 = Application.create!(name: "Florence Bigsby", street_address: "202 E Washington Ave", city: "Madison", state: "WI", zipcode: 60637, status: "Pending", description: "I love cats")
    @application_3 = Application.create!(name: "Todd Matthews", street_address: "620 W 11th St", city: "Hastings", state: "MN", zipcode: 55033, status: "Pending", description: "We have the same name")

    @application_1.pets << @pet_1
    @application_2.pets << @pet_2
    @application_3.pets << @pet_5
  end

  describe 'When I visit the admin shelter index' do
    describe "I see all shelters in the system listed in reverse alphabetical order by name" do
      it 'sorts shelters in reverse alphabetical order by name' do
        visit "/admin/shelters"

        expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
        expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
        expect('Aurora shelter').to_not appear_before('RGV animal shelter')
      end
    end
  end

  describe 'When I visit the admin shelter index' do
    describe "I see a section for 'Shelter's with Pending Applications" do

      it 'Lists all shelters that have pending applications' do
        visit "/admin/shelters"

        expect(page).to have_content("Shelters with Pending Applications")

        within('#pending-apps') do
          expect(page).to have_content('Aurora shelter')
          expect(page).to have_content('Fancy pets of Colorado')
          expect(page).to_not have_content('RGV animal shelter')
        end
      end
    end
  end
end
