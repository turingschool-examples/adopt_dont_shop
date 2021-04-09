require 'rails_helper'

RSpec.describe "adimin shelters show page" do
  it "can see shelter statistics for number of adoptable pets" do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    pet_2 = shelter_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')
    pet_3 = shelter_1.pets.create(adoptable: true, age: 1, breed: 'pit bull', name: 'Dug')
    pet_4 = shelter_1.pets.create(adoptable: true, age: 3, breed: 'chihuahua', name: 'Tiny')
    pet_5 = shelter_1.pets.create(adoptable: false, age: 1, breed: 'shorthair', name: 'Mr. Cat')
    pet_6 = shelter_1.pets.create(adoptable: false, age: 3, breed: 'lab', name: 'Max')

    visit "/admin/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.count_of_adoptable_pets)
  end
end
