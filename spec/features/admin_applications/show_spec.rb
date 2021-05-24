require 'rails_helper'

RSpec.describe 'admin_applications show page', type: :feature do
  before (:each) do
    @shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @application1 = Application.create!(name: "Suzie Q", street_address: '1311 E 27TH AVE', city: 'DENVER', state: 'CO', zip_code: 80205, statement: "TEST", status: 'Pending')
    @application2 = Application.create!(name: "Jane Doe", street_address: '201 W Colfax Ave', city: 'Denver', state: 'CO', zip_code: 80202, statement: "TEST", status: 'Pending')
    @application3 = Application.create!(name: "Barak Obama", street_address: '1600 Pennsylvania Ave', city: 'Washington', state: 'DC', zip_code: 20500, statement: "TEST", status: 'Pending')

    @application_pet1 = ApplicationPet.create!(application: @application1, pet: @pet_1)
    @application_pet1 = ApplicationPet.create!(application: @application1, pet: @pet_4)
    @application_pet2 = ApplicationPet.create!(application: @application2, pet: @pet_3)
    @application_pet3 = ApplicationPet.create!(application: @application3, pet: @pet_2)
  end

  describe 'default show page appearance' do
    it 'provides a summary of the submitted application' do
      visit "/admin/applications/#{@application1.id}"

      expect(page).to have_content('Applicant Details:')
      expect(page).to have_content('Application Status:')
      expect(page).to have_content('Pending')
      expect(page).to have_content('Name:')
      expect(page).to have_content('Suzie Q')
      expect(page).to have_content('Street Address:')
      expect(page).to have_content('1311 E 27TH AVE')
      expect(page).to have_content('City:')
      expect(page).to have_content('DENVER')
      expect(page).to have_content('State:')
      expect(page).to have_content('CO')
      expect(page).to have_content('Zip Code:')
      expect(page).to have_content('80205')
      expect(page).to have_content('Pets To Be Adopted:')
      expect(page).to have_content('Mr. Pirate')
      expect(page).to have_content('Ann')
      expect(page).to have_content('Adoption Statement')
      expect(page).to have_content('TEST')
    end
    it 'has buttons to approve and reject each pet by default' do
      visit "/admin/applications/#{@application1.id}"

      within "#pets_adopting > tr:nth-child(2)" do
        expect(page).to have_link('Approve')
        expect(page).to have_link('Reject')
      end
      within "#pets_adopting > tr:nth-child(2)" do
        expect(page).to have_link('Approve')
        expect(page).to have_link('Reject')
      end
    end
    it 'allows you to approve/reject pets one by one' do
      visit "/admin/applications/#{@application1.id}"

      click_link('Approve', match: :first)

      within "#pets_adopting > tr:nth-child(2)" do
        expect(page).to have_content('Approved')
        expect(page).to_not have_link('Approve')
        expect(page).to_not have_link('Reject')
      end

      click_link('Reject')

      within "#pets_adopting > tr:nth-child(3)" do
        expect(page).to have_content('Rejected')
        expect(page).to_not have_link('Approve')
        expect(page).to_not have_link('Reject')
      end
    end
  end
end