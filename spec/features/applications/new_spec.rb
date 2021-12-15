require 'rails_helper'

RSpec.describe Application do
  it 'has a link for starting an application' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"
    click_on("Start an Application")
    expect(page).to have_current_path("/applications/new")

    fill_in 'name', with: "Ruth"
    fill_in 'address', with: "123 sesame street"
    fill_in 'state', with: "CO"
    fill_in 'city', with: "Denver"
    fill_in 'zip', with: "80018"
    fill_in 'description', with: "smoke free"
    click_on("Submit")


    expect(page).to have_content("Ruth")
    expect(page).to have_content("123 sesame street")
    expect(page).to have_content("CO")
    expect(page).to have_content("Denver")
    expect(page).to have_content("80018")
  end
end
