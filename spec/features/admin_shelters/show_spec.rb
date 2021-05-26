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
    @application_pet4 = ApplicationPet.create!(application: @application2, pet: @pet_1)
    @application_pet4 = ApplicationPet.create!(application: @application1, pet: @pet_2)
  end

  describe 'default page appearance' do
    it 'lists the name and address of the shelter' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content('Fluffy Friends')
      expect(page).to have_content('1311 E 27th Ave Denver CO 80205')
    end
    it 'has a section titled shelter statistics' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content('Shelter Statistics')
    end
    it 'includes the average age of all the pets at the shelter' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content('Average Pet Age')
      expect(page).to have_content('4.33 years')
    end
    it 'includes the number of adoptable pets at the shelter' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content('Number of Adoptable Pets')
      expect(page).to have_content('2 pets')
    end
    it 'includes the number of pets adopted from the shelter' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content('Number of Pets Adopted')
      expect(page).to have_content('1 pets')
    end
    it 'has a section that details pets needing action' do
      visit "/admin/shelters/#{@shelter1.id}"
      save_and_open_page

      expect(page).to have_content('Pets Requiring Action')
      expect(page).to have_content('Pet')
      expect(page).to have_content('Application(s) Requiring Review')
    end
    it 'has links to the show pages for applications that need action' do
      visit "/admin/shelters/#{@shelter1.id}"

      expect(page).to have_content('Clawdia')
      expect(page).to have_link("View Application #{@application1.id}")
      expect(page).to have_link("View Application #{@application3.id}")

      click_link "View Application #{@application1.id}"

      expect(current_path).to eq("/admin/applications/#{@application1.id}")
    end
  end
end