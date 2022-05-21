require 'rails_helper'

RSpec.describe 'the application form index' do
  it 'lists all the applications with their attributes' do
    shelter_1 = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 5)
    shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: true, rank: 9)

    pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
    pet_3 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_2.id)

    applicationform_1 = ApplicationForm.create(name: "Hank", street_address: "1234 Some Street", city: "Aurora", state: "CO", zip_code: "80015", description: "I'd like an animal please", status: "In Progress")
    applicationform_2 = ApplicationForm.create(name: "Levi", street_address: "4321 Another Street", city: "Los Angeles", state: "CA", zip_code: "12345", description: "wanna animal", status: "Pending")
    applicationform_3 = ApplicationForm.create(name: "Diana", street_address: "4444 Oneother Court", city: "Detroit", state: "MI", zip_code: "54321", description: "I love animals", status: "Accepted")
    applicationform_4 = ApplicationForm.create(name: "Michael", street_address: "621311 Thisdude Street", city: "Philadelphia", state: "PA", zip_code: "19147", description: "Definitely NOT for fighting", status: "Rejected")

    application_pets_1 = ApplicationPet.create(pet: pet_1, application_form: applicationform_1)
    application_pets_2 = ApplicationPet.create(pet: pet_3, application_form: applicationform_2)
    application_pets_3 = ApplicationPet.create(pet: pet_1, application_form: applicationform_2)

    visit "/application_forms"
    #
    save_and_open_page
    #
    # expect(page).to have_content(pet_1.name)
    # expect(page).to have_content(pet_1.breed)
    # expect(page).to have_content(pet_1.age)
    # expect(page).to have_content(shelter.name)
    #
    # expect(page).to have_content(pet_2.name)
    # expect(page).to have_content(pet_2.breed)
    # expect(page).to have_content(pet_2.age)
    # expect(page).to have_content(shelter.name)
  end
end
