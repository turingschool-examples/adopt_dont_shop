require 'rails_helper'

RSpec.describe 'the shelter show' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.adoptable)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.shelter_name)
  end

  it "allows the user to delete a pet" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    click_on("Delete #{pet.name}")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet.name)
  end

  it 'displays pet is not adoptable on show page after appliation approved' do
    shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
    pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create!(name: 'Parker', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    pet3 = Pet.create!(name: 'Amanda', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress',
    )

    app_pet_1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    app_pet_2 = ApplicationPet.create!(application_id: application.id, pet_id: pet2.id)
    app_pet_3 = ApplicationPet.create!(application_id: application.id, pet_id: pet3.id)

    visit "/admin/applications/#{application.id}"
    click_button "Approve #{pet1.name}"
    click_button "Approve #{pet2.name}"
    click_button "Approve #{pet3.name}"

    visit "/pets/#{pet1.id}"
    expect(page).to have_content('Not adoptable')
  end
end
