require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)


  end

  it 'lists shelters reverse alphabetically by name' do 
    visit '/admin/shelters'

    expect(@shelter_2.name).to appear_before(@shelter_3.name)
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
  end 

  it 'has a section that lists shelters with pending status' do 
    application_1 = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd", city: "Denver", state: "CO", zipcode: 80123)
    application_2 = Application.create!(name: "Kim G", street_address:"2000 Something Blvd", city: "Denver", state: "CO", zipcode: 80124)
    application_pet1 = ApplicationPet.create!(application: application_1, pet: @pirate)
    application_1.description = "I am lonely and need fluffy mammals"
    application_1.status = "Pending"
    application_1.save

    visit '/admin/shelters'
 
    within("#Pending_shelters") do
     expect(page).to have_content("Shelters with Pending Applications:")
     expect(page).to have_content(@shelter_1.name)
     expect(page).to_not have_content(@shelter_2.name)
     expect(page).to_not have_content(@shelter_3.name)
    end
  end 
end 