require 'rails_helper'
# #10
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
# ```

RSpec.describe '#/admin/shelters/index' do 
  before(:each) do 
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @applicant1 = Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", status: 'Pending')
    @applicant2 = Applicant.create!(name: "Pink Flyod", street_address: "5150 High St", city: "Crater Lake", state: "None", zip: "12345", status: 'Pending')
  end
    it 'lists all the shelters in reverse alphabetical order' do 
      visit "/admin/shelters"
     expect(@shelter_2.name).to appear_before(@shelter_1.name)
     expect(@shelter_3.name).to appear_before(@shelter_1.name)
  end 


# 11. Shelters with Pending Applications
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelter's with Pending Applications"
# And in this section I see the name of every shelter that has a pending application
   it 'has a section with all the Shelters pending applications' do 
     visit "/admin/shelters"
     @applicant1.pets << @pet1 << @pet2
     @applicant2.pets << @pet3 
     binding.pry
    within ("#Shelters_with_pending_applications") do 
     expect(page).to have_content(@shelter_1.name)
     expect(page).to have_content(@shelter_3.name)
     expect(page).to_not have_content(@shelter_2.name)
     expect(page).to have_content("Shelters with pending applications")
    end 
   end
end