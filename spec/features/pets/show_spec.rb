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

  it "correctly displays that a pet is no longer adopable once an approved app is done for them" do
    shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)
    marlowe = shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')
    app1 = Application.create!(name: 'Frank Sinatra', street_address: '69 Sinatra Way', city: 'Nashville', state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs", status: 'In Progress')
    PetApplication.create!(pet: marlowe, application: app1)

    visit "/admin/applications/#{app1.id}"
    within "#pet-#{marlowe.id}" do
      click_button("Approve This Application")
    end

    visit "/pets/#{marlowe.id}"
    expect(page).to have_content("false")
  end
end
