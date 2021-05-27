require 'rails_helper'

RSpec.describe 'the pet show' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', shelter_id: shelter.id)
    pet = Pet.create(name: 'Joe', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content('Yes')
    expect(page).to have_content(pet.breed)
  end

  it "allows the user to delete a pet" do
    shelter = Shelter.create(name: 'Fluffy Friends', street_address: '1311 E 27th Ave', city: 'Denver', state: 'CO', zip_code: 80205, foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Oleg', shelter_id: shelter.id)
    pet = Pet.create(name: 'Joe', age: 1, breed: 'Racoon', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"
    
    click_link("Delete")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet.name)
  end
end
