require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'when i visit the applications show page' do
    it 'then i can see the name, full address, description, names of pets, and application status of the specified application' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)
      pancho = Pet.create!(adoptable: true, age: 5, breed: "Chiuahua", name: "Pancho", shelter_id: shelter.id)
      spot_application = PetApplication.create!(application_id: application.id, pet_id: spot.id, status: application.status)
      frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

      visit "/applications/#{application.id}"

      expect(page).to have_content("Jerry Rice")
      expect(page).to have_content("123 Main Street")
      expect(page).to have_content("Honolulu")
      expect(page).to have_content("HI")
      expect(page).to have_content("We love doggos!")
      expect(page).to have_link("Spot")
      expect(page).to have_link("Frenchie")
      expect(page).to have_content("In Progress")
    end

    it 'if the application has not been submitted/in progress, then i will see a section where i can search for pets by name ' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)

      visit "/applications/#{application.id}"

      fill_in "Search", with: "Spot"
      click_on "Search"

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Spot")
      expect(page).to have_content("2")
      expect(page).to have_content("Dalmatian")
      expect(page).to_not have_content("Frenchie")
    end

    it 'if the application has been submitted, then the Add a Pet to this Application section wont be visible' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "Pending")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)

      visit "/applications/#{application.id}"

      expect(page).to_not have_content("Add a Pet to this Application")
    end


    it 'when i search for a pet by name, i see a button next to the pets name and if i click the button it will add that pet to the application' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)
      pancho = Pet.create!(adoptable: true, age: 5, breed: "Chiuahua", name: "Pancho", shelter_id: shelter.id)
      spot_application = PetApplication.create!(application_id: application.id, pet_id: spot.id, status: application.status)
      frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

      visit "/applications/#{application.id}"

      expect(page).to_not have_link("Pancho")

      fill_in 'Search', with: "Pancho"
      click_on 'Search'
      click_on 'Adopt this Pet'

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_link("Pancho")

      click_on "Pancho"
      expect(current_path).to eq("/pets/#{pancho.id}")
    end

    it 'submits the application and asks for input on why I would be a good owner for these pet(s)' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)
      spot_application = PetApplication.create!(application_id: application.id, pet_id: spot.id, status: application.status)

      visit "/applications/#{application.id}"
      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_button("Submit Application")
      expect(page).to have_content("Application Status: In Progress")
      expect(page).to have_content("What makes you a good owner?")
      fill_in :good_owner, with: "I love dogs"
      click_on "Submit Application"

      expect(current_path).to eq("/applications/#{application.id}")
      expect(page).to have_content("Application Status: Pending")
      expect(page).to have_content("Spot")
      expect(page).to_not have_content("Add More Pets")
    end

    it 'has no pets on an application' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)

      visit "/applications/#{application.id}"

      expect(page).to_not have_button("Submit Application")
    end

    it 'can find a pet with a partial search do' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)
      fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FREnCH ToAsT", shelter_id: shelter.id)
      spot_application = PetApplication.create!(application_id: application.id, pet_id: spot.id, status: application.status)
      frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

      visit "/applications/#{frenchie_application.application.id}"
      expect(current_path).to eq("/applications/#{frenchie_application.application.id}")

      fill_in :search, with: "fr"
      click_on "Search"

      expect(page).to have_content("Frenchie")
      expect(page).to have_content("FREnCH ToAsT")
    end

    it 'can find a pet with a case insensitive search' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id)
      fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FREnCH ToAsT", shelter_id: shelter.id)
      spot_application = PetApplication.create!(application_id: application.id, pet_id: spot.id, status: application.status)
      frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

      visit "/applications/#{frenchie_application.application.id}"
      fill_in :search, with: "FrEnch"
      click_on "Search"

      expect(page).to have_content("Frenchie")
      expect(page).to have_content("FREnCH ToAsT")
    end
  end
end
