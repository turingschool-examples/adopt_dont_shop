require 'rails_helper'

RSpec.describe 'the admin applications show' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd", city: "Denver", state: "CO", zipcode: 80123)
    @application_2 = Application.create!(name: "Kim G", street_address:"2000 Something Blvd", city: "Denver", state: "CO", zipcode: 80124)
    @application_pet1 = ApplicationPet.create!(application: application_1, pet: @pet_1)
    @application_1.description = "I am lonely and need fluffy mammals"
    @application_1.status = "Pending"
    @application_1.save
  end

  it 'approve a pet for adoption' do 
    visit "admin/applications/#{application_1.id}"

    


  end



end