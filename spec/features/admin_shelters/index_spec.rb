require 'rails_helper'

RSpec.describe 'admin_shelters index page', type: :feature do
  before (:each) do
    @shelter1 = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: 'Coon City', street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, foster_program: false, rank: 5)
    @shelter3 = Shelter.create(name: 'Cat Savers', street_address: '1455 High St', city: 'Denver', state: 'CO', zip_code: 80218, foster_program: true, rank: 10)

    @pet_1 = @shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application1 = Application.create!(name: "Suzie Q", street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, statement: "TEST", status: 'Pending')
    @application2 = Application.create!(name: "Jane Doe", street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, statement: "TEST", status: 'Pending')
    @application3 = Application.create!(name: "Barak Obama", street_address: '1600 Pennsylvania Ave', city: 'Washington', state: 'DC', zip_code: 20500, statement: "TEST", status: 'Pending')

    @application_pet1 = ApplicationPet.create!(application: @application1, pet: @pet_1)
    @application_pet2 = ApplicationPet.create!(application: @application2, pet: @pet_3)
    @application_pet3 = ApplicationPet.create!(application: @application3, pet: @pet_2)
  end

  describe 'default page appearance' do
    it 'has a table showing all shelters in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(page).to have_content('All Shelters')

      within "#admin-shelters-all > tr:nth-child(2)" do
        expect(page).to have_content(@shelter1.name)
      end

      within "#admin-shelters-all > tr:nth-child(3)" do
        expect(page).to have_content(@shelter2.name)
      end

      within "#admin-shelters-all > tr:nth-child(4)" do
        expect(page).to have_content(@shelter3.name)
      end
    end

    it 'has a table showing only shelters with pending applications' do
      visit '/admin/shelters'

      expect(page).to have_content('Shelters With Pending Applications')

      within "#admin-shelters-pending-apps > tr:nth-child(2)" do
        expect(page).to have_content(@shelter1.name)
      end

      within "#admin-shelters-pending-apps > tr:nth-child(3)" do
        expect(page).to have_content(@shelter3.name)
      end
    end
  end
end