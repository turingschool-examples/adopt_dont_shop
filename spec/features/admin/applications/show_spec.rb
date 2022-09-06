require 'rails_helper'

RSpec.describe 'the admin application view page' do
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
    @application_1.pets << @pet_3
    @application_2.pets << @pet_2
    @application_3.pets << @pet_5
  end

  describe 'when I visit the admin application show page' do
    it 'displays all pets applying for' do
      visit "admin/applications/#{@application_1.id}"

      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content('Bark Hamill')

      expect(page).to_not have_content('Mr. Pig')
    end

    it 'links button to approve a pet, redirects pet to show page' do
      visit "admin/applications/#{@application_2.id}"

      expect(page).to have_content('Mr. Pig')

      click_on 'Approve'

      expect(current_path).to eq("/admin/applications/#{@application_2.id}")
      expect(page).to have_content('Mr. Pig')
    end

    it 'once a pet is approved, I see an indicator that the pet has been approved and the button is gone' do
      visit "admin/applications/#{@application_2.id}"

      expect(page).to have_content('Mr. Pig')

      within(".pet_#{@pet_2.id}") do
        click_on 'Approve'
      end

      within(".pet_#{@pet_2.id}") do
        expect(page).to_not have_content('Approve')
        expect(page).to have_content('Approved')
      end
    end
  end
end
