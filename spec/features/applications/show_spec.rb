require 'rails_helper'

RSpec.describe 'the application show' do
  it 'shows the applicant attributes' do
    application = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")

    visit "/applications/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)

  end

  it "Shows why the applicant says they'd be a good home for this pet(s)" do
    application = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")

    visit "/applications/#{application.id}"
    expect(page).to have_content(application.description)
  end

  it "names of all pets that this application is for (all names of pets should be links to their show page)" do
    shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
    pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
    app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)
    app_pet_1 = ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id)

    visit "/applications/#{application_1.id}"

    expect(page).to have_link("#{pet_1.name}")
    expect(page).to have_link("#{pet_2.name}")
  end

  describe 'User Story #4' do
    describe 'Visit application show page' do
      it 'shows add a pet to this application' do
        shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
        pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)

        visit "/applications/#{application_1.id}"

        expect(page).to have_content('Add a pet to this application')
        fill_in "search_for_pet", with: "Scooby"

        click_on "Submit"

        expect(page).to have_content "Scooby"

      end
    end
  end
  describe 'User Story #5' do
    describe 'Visit application show page' do
      it 'shows button next to pets that match me search' do
        shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
        pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)
        # app_pet_1 = ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id)

        visit "/applications/#{application_1.id}"

        expect(page).to have_content('Add a pet to this application')
        fill_in "search_for_pet", with: "#{pet_1.name}"

        click_on "Submit"

        expect(page).to have_content "#{pet_1.name}"
        expect(page).to have_button "Adopt"

        click_on "Adopt"

        expect(current_path).to eq("/applications/#{application_1.id}")

        expect(page).to have_content("Pets I want to Adopt: #{pet_1.name}")
        expect(page).to_not have_content("Pets I want to Adopt: #{pet_2.name}")
      end
    end
  end

  describe 'User Story #7' do
    describe 'Visit application show page And I have added one or more pets to the application' do
      it 'Then I see a section to submit my application but do not submit application' do
        shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
        pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)

        visit "/applications/#{application_1.id}"
        
        fill_in "search_for_pet", with: "#{pet_1.name}"
        click_on "Submit"

        expect(page).to_not have_button("Submit my Application")
      end
    end
  end

  describe 'User Story #8' do
    describe 'Visit application show page And I search for pets by name' do
      it 'Then I see any pet whose name PARTIALLY matches my search' do
        shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
        pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
        app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)

        visit "/applications/#{application_1.id}"
        
        fill_in "search_for_pet", with: "Sc"
        click_on "Submit"

        expect(page).to have_content("Scooby")
        expect(page).to have_content("Scrappy")
      end
    end
  end
end
