require 'rails_helper'

RSpec.describe "the application show page" do
  it "shows the application and all its attributes" do
    # Application Show Page
    #
    # As a visitor
    # When I visit an applications show page
    # Then I can see the following:
    # - Name of the Applicant
    # - Full Address of the Applicant including street address, city, state, and zip code
    # - Description of why the applicant says they'd be a good home for this pet(s)
    # - names of all pets that this application is for (all names of pets should be links to their show page)
    # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create(name: "Gertie", age: 1, breed: "Border Collie", adoptable: true, shelter_id: shelter.id)
    application1 = Application.create!(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, description: 'I am depressed', status: 'In Progress')
    PetApplication.create!(application: application1, pet: pet1)
    PetApplication.create!(application: application1, pet: pet2)


    visit ("/applications/#{application1.id}")

    expect(page).to have_content(application1.name)
    expect(page).to have_content("Address: #{application1.street} #{application1.city}, #{application1.state} #{application1.zip_code}")
    expect(page).to have_content("Description: #{application1.description}")
    expect(page).to have_link(application1.pets[0].name)
    expect(page).to have_link(application1.pets[1].name)
    expect(page).to have_content("Status: #{application1.status}")

    click_link("#{application1.pets[0].name}")

    expect(current_path).to eq("/pets/#{pet1.id}")

    visit ("/applications/#{application1.id}")

    click_link("#{application1.pets[1].name}")

    expect(current_path).to eq("/pets/#{pet2.id}")
  end

  it 'implements a search bar for pet names' do
    # Searching for Pets for an Application

    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create!(name: "Gertie", age: 1, breed: "Border Collie", adoptable: true, shelter_id: shelter.id)
    application1 = Application.create!(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, description: 'I am depressed', status: 'In Progress')

    visit ("/applications/#{application1.id}")

    fill_in('search_by_name', with: 'Scooby')
    click_button("Find this pet!")
    save_and_open_page


  end
end
