require 'rails_helper'

RSpec.describe 'applicant show page' do

  it 'user story 1' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    bob_1 = Applicant.create(name: "Billy Bob", address: "Street address 6093", description: "I'm bob", status: "In Progress", zip: 22323, city: "denver", state: "CO")
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    app_1 = ApplicantPet.create(applicant: bob_1, pet: pet_1)
    app_2 = ApplicantPet.create(applicant: bob_1, pet: pet_4)

    visit "/applicants/#{bob_1.id}"
    expect(current_path).to eq("/applicants/#{bob_1.id}")

    expect(page).to have_content("Billy Bob")
    expect(page).to have_content("Street address 6093")
    expect(page).to have_content("I'm bob")
    expect(page).to have_content(22323)

    expect(page).to have_link('Ann')
    expect(page).to have_link('Mr. Pirate')

    click_link('Mr. Pirate')

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it 'user story 4' do
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    bob_1 = Applicant.create(name: "Billy Bob", address: "Street address 6093", description: "I'm bob", status: "In Progress", zip: 22323, city: "denver", state: "CO")
    pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    pet_4 = shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    app_1 = ApplicantPet.create(applicant: bob_1, pet: pet_1)
    app_2 = ApplicantPet.create(applicant: bob_1, pet: pet_4)

    visit "/applicants/#{bob_1.id}"
    expect(current_path).to eq("/applicants/#{bob_1.id}")

    expect(page).to have_content("In Progress")
    expect(page).to_not have_content('Clawdia')
    expect(page).to have_content("Add a Pet to this Application")

    fill_in 'name', with: 'Clawdia'
    click_on 'Submit'

    expect(current_path).to eq("/applicants/#{bob_1.id}")
    expect(page).to have_content('Clawdia')
  end
end
