require 'rails_helper'

RSpec.describe 'the shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", description:"I love dogs and would be such a good dog mom", status: "In Progress")
    @application2 = Application.create!(name:"Dominic OD", street_address:"5250 Town and Country Blvd.", city:"Frisco", state:"Texas", zipcode:"75034", description:"I like cats.", status: "Pending")
    PetApplication.create!(pet: @pet1, application: @application1)
    PetApplication.create!(pet: @pet1, application: @application2)
    PetApplication.create!(pet: @pet3, application: @application1)
    PetApplication.create!(pet: @pet3, application: @application2)
    PetApplication.create!(pet: @pet2, application: @application1)
  end

  describe 'As an admin' do
    describe 'when I visit the admin shelter index ("/admin/shelters")' do
      it 'then I see all Shelters in the system listed in reverse alphabetical order by name' do
        visit '/admin/shelters'

        expect(@shelter_2.name).to appear_before(@shelter_3.name)
        expect(@shelter_3.name).to appear_before(@shelter_1.name)
      end

      it 'I see a section for "Shelters with Pending Applications"' do
        visit '/admin/shelters'

        expect(page).to have_content("Shelters with Pending Applications")
      end

      it 'In the "Shelters with Pending Applications" section, I see the name of every shelter that has a pending application' do
        visit '/admin/shelters'

        within("#pending_apps") do
          expect(page).to have_content("#{@shelter_1.name}")
          expect(page).to have_content("#{@shelter_3.name}")
          expect(page).to_not have_content("#{@shelter_2.name}")
        end
      end
     end
  end
end
