require 'rails_helper'

RSpec.describe "Admin Applications" do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    visit "/pets"

    click_link "Start an Application"

    fill_in :name, with: "Billy Jonston"
    fill_in :street_address, with: "123 Main Lane"
    fill_in :city, with: "Luxemburg"
    fill_in :state, with: "Mars"
    fill_in :zip_code, with: "12121"
    click_button "Submit"

    fill_in :search, with: "Mr. Pirate"
    click_button "Search"
    click_button "Adopt this Pet"

    fill_in :search, with: "Clawdia"
    click_button "Search"
    click_button "Adopt this Pet"

    click_button "Submit Application"

    @application = Application.first

    visit "/admin/applications/#{@application.id}"
  end

  describe 'approving an application' do
    it 'has a button next to each desired pet' do
      within "#pet-#{@pet1.id}" do
        click_button "Approve Pet"
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within "#pet-#{@pet1.id}" do
        expect(page).to_not have_button("Approve Pet")
        expect(page).to have_content("Approved")
      end

      within "#pet-#{@pet2.id}" do
        click_button "Approve Pet"
      end

      expect(current_path).to eq("/admin/applications/#{@application.id}")

      within "#pet-#{@pet2.id}" do
        expect(page).to_not have_button("Approve Pet")
        expect(page).to have_content("Approved")
      end
    end
  end
end
