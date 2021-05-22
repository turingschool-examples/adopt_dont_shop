require 'rails_helper'

RSpec.describe 'admin_shelters index page', type: :feature do
  before (:each) do
    @application1 = Application.create!(name: "Big Bird", street_address: '1311 E 27TH AVE', city: 'DENVER', state: 'CO', zip_code: 80205, statement: nil)
    @shelter1 = Shelter.create!(foster_program: true, name: 'Cats R Us', city: 'Denver', rank: 1)
    @shelter2 = Shelter.create!(foster_program: true, name: 'Coon Haven', city: 'Brighton', rank: 2)
    @shelter3 = Shelter.create!(foster_program: true, name: 'The Pound', city: 'Denver', rank: 3)
    @pet1 = @shelter1.pets.create!(adoptable: true, age: 0, breed: 'Siamese Cat', name: 'Pear')
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 1, breed: 'Blue Russian Cat', name: 'Oleg')
    @pet3 = @shelter1.pets.create!(adoptable: true, age: 2, breed: 'Domestic Short Hair Cat', name: 'Ralph')
  end

  describe 'default page appearance' do
    it 'has a table showing all shelters in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(page).to have_content('All Shelters')

      within "#admin-shelters-all > tr:nth-child(2)" do
        expect(page).to have_content(@shelter3.name)
      end

      within "#admin-shelters-all > tr:nth-child(3)" do
        expect(page).to have_content(@shelter2.name)
      end

      within "#admin-shelters-all > tr:nth-child(4)" do
        expect(page).to have_content(@shelter1.name)
      end
    end
  end
end