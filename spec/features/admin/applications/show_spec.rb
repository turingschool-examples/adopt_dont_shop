require 'rails_helper'

RSpec.describe 'Admin/applications#show' do
  it 'should show the pet applications for each application based on application id' do
    shelter_1 = Shelter.create!(name: "Dog Home", city: "Denver", rank: 1, foster_program: true)
    shelter_2 = Shelter.create!(name: "Paw Place", city: "Boulder", rank: 2, foster_program: true)
    shelter_3 = Shelter.create!(name: "Cat Home", city: "Denver", rank: 3, foster_program: true)

    application_1 = Application.create!(id: 1, name: "John Doe", street_address: "123 Main St", city: "New York", state: "NY", zipcode: 20001)
    application_2 = Application.create!(id: 2, name: "Jane Doe", street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 30002)

    pet_1 = Pet.create!(id: 1, name: "Fido", breed: "Poodle", age: 2, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(id: 2, name: "Buddy", breed: "Poodle", age: 3, adoptable: true, shelter_id: shelter_2.id)
    pet_3 = Pet.create!(id: 3, name: "Bella", breed: "Labrador", age: 4, adoptable: true, shelter_id: shelter_3.id)
    pet_4 = Pet.create!(id: 4, name: "Bruce", breed: "Pug", age: 4, adoptable: true, shelter_id: shelter_3.id)

    pet_application_1 = PetApplication.create!(application_id: application_1.id, pet_id: pet_1.id)
    pet_application_2 = PetApplication.create!(application_id: application_1.id, pet_id: pet_2.id)
    pet_application_3 = PetApplication.create!(application_id: application_1.id, pet_id: pet_3.id)

    visit '/admin/applications/1'

    expect(page).to have_content("John Doe")
    expect(page).to have_no_content("Jane Doe")

    within("#pet-#{pet_application_1.id}") do
      expect(page).to have_content("Fido")
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    within("#pet-#{pet_application_2.id}") do
      expect(page).to have_content("Buddy")
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    within("#pet-#{pet_application_3.id}") do
      expect(page).to have_content("Bella")
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    expect(page).to_not have_content("Bruce")
  end

  it 'should click a button to approve/reject a pet which returns it to the admin show page and it shows that pet has been approved/rejected' do
    shelter_1 = Shelter.create!(name: "Dog Home", city: "Denver", rank: 1, foster_program: true)

    application_1 = Application.create!(id: 1, name: "John Doe", street_address: "123 Main St", city: "New York", state: "NY", zipcode: 20001)

    pet_1 = Pet.create!(id: 1, name: "Fido", breed: "Poodle", age: 2, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(id: 2, name: "Buddy", breed: "Poodle", age: 3, adoptable: true, shelter_id: shelter_1.id)
    pet_3 = Pet.create!(id: 3, name: "Bella", breed: "Labrador", age: 4, adoptable: true, shelter_id: shelter_1.id)

    pet_application_1 = PetApplication.create!(application_id: application_1.id, pet_id: pet_1.id)
    pet_application_2 = PetApplication.create!(application_id: application_1.id, pet_id: pet_2.id)
    pet_application_3 = PetApplication.create!(application_id: application_1.id, pet_id: pet_3.id)

    visit '/admin/applications/1'

    within("#pet-#{pet_application_1.id}") do
      expect(page).to have_content("Fido")

      click_button "Approve"

      expect(page).to have_content("Approved")
      expect(page).to have_no_button("Approve")
      expect(page).to have_no_button("Reject")
    end

    within("#pet-#{pet_application_2.id}") do
      expect(page).to have_content("Buddy")

      click_button("Reject")

      expect(page).to have_content("Rejected")
      expect(page).to have_no_button("Approve")
      expect(page).to have_no_button("Reject")
    end

    within("#pet-#{pet_application_3.id}") do
      expect(page).to have_content("Bella")

      click_button("Approve")

      expect(page).to have_content("Approved")
      expect(page).to have_no_button("Approve")
      expect(page).to have_no_button("Reject")
    end
  end

  it "after approving or rejecting a pet application on an application page, it should visit another application page and see the same pet's status unaffected" do
    shelter_1 = Shelter.create!(id: 1, name: "Dog Home", city: "Denver", rank: 1, foster_program: true)

    application_1 = Application.create!(id: 1, name: "John Doe", street_address: "123 Main St", city: "New York", state: "NY", zipcode: 20001)
    application_2 = Application.create!(id: 2, name: "Jane Doe", street_address: "456 Main St", city: "Boston", state: "MA", zipcode: 30002)

    pet_1 = Pet.create!(id: 1, name: "Fido", breed: "Poodle", age: 2, adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(id: 2, name: "Buddy", breed: "Poodle", age: 3, adoptable: true, shelter_id: shelter_1.id)

    pet_application_1 = PetApplication.create!(id: 1, application_id: application_1.id, pet_id: pet_1.id)
    pet_application_2 = PetApplication.create!(id: 2, application_id: application_1.id, pet_id: pet_2.id)

    pet_application_3 = PetApplication.create!(id: 3, application_id: application_2.id, pet_id: pet_1.id)
    pet_application_4 = PetApplication.create!(id: 4, application_id: application_2.id, pet_id: pet_2.id)

    visit '/admin/applications/1'

    within("#pet-#{pet_application_1.id}") do
      expect(page).to have_content("Fido")

      click_button "Approve"

      expect(page).to have_content("Approved")
    end

    visit '/admin/applications/2'

    within("#pet-#{pet_application_3.id}") do
      expect(page).to have_content("Fido")
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    visit '/admin/applications/1'

    within("#pet-#{pet_application_2.id}") do
      expect(page).to have_content("Buddy")

      click_button("Reject")

      expect(page).to have_content("Rejected")
    end

    visit '/admin/applications/2'

    within("#pet-#{pet_application_4.id}") do
      expect(page).to have_content("Buddy")
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end
end