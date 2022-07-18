require 'rails_helper'

RSpec.describe 'application show page' do
  it 'shows the applicant and all of their attributes' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    applicant = Application.create!(
              name: 'Mike Dao',
              street_address: '245 Maple St',
              city: 'Centennial',
              state: 'Colorado',
              zip_code: '80112',
              applicant_bio: 'My dog needs another to chase up trees.',
              application_status: 'Pending')

      pet = applicant.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
      pet2 = applicant.pets.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
      pet3 = applicant.pets.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
      pet4 = applicant.pets.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

      visit "/applications/#{applicant.id}"

      expect(page).to have_content('Mike Dao')
  end

  it 'is shows the names of all pets in which the applicant is applying' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    mike = Application.create!(
              name: 'Mike Dao',
              street_address: '245 Maple St',
              city: 'Centennial',
              state: 'Colorado',
              zip_code: '80112',
              applicant_bio: 'My dog needs another to chase up trees.',
              application_status: 'Pending')


    chris = Application.create!(
              name: 'Chris Simmons',
              street_address: '533 Oak St',
              city: 'Columbus',
              state: 'Ohio',
              zip_code: '43004',
              applicant_bio: 'Because how much more work could a third cat be?',
              application_status: 'In Progress')

    dani = Application.create!(
              name: 'Dani Coleman',
              street_address: '912 Willow St',
              city: 'Arvada',
              state: 'Colorado',
              zip_code: '80003',
              applicant_bio: 'Because I am just awesome.',
              application_status: 'Accepted')

    charlie = mike.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
    mina = dani.pets.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
    chloe = chris.pets.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
    vida = dani.pets.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

    visit "/applications/#{mike.id}"

    expect(page).to have_content('Mike Dao')
    expect(page).to have_link('Charlie')
    expect(page).to_not have_content('Mina')
    expect(page).to_not have_content('Chloe')
    expect(page).to_not have_content('Vida')

    visit "/applications/#{dani.id}"

    expect(page).to have_content('Dani Coleman')
    expect(page).to have_link('Mina')
    expect(page).to have_link('Vida')
    expect(page).to_not have_content('Charlie')
    expect(page).to_not have_content('Chloe')

    visit "/applications/#{chris.id}"

    expect(page).to have_content('Chris Simmons')
    expect(page).to have_link('Chloe')
    expect(page).to_not have_content('Charlie')
    expect(page).to_not have_content('Mina')
    expect(page).to_not have_content('Vida')
  end

  it 'can search for pets for an application' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    mike = Application.create!(
              name: 'Mike Dao',
              street_address: '245 Maple St',
              city: 'Centennial',
              state: 'Colorado',
              zip_code: '80112',
              applicant_bio: 'My dog needs another to chase up trees.',
              application_status: 'In Progress')
    chris = Application.create!(
              name: 'Chris Simmons',
              street_address: '533 Oak St',
              city: 'Columbus',
              state: 'Ohio',
              zip_code: '43004',
              applicant_bio: 'Because how much more work could a third cat be?',
              application_status: 'In Progress')
    dani = Application.create!(
              name: 'Dani Coleman',
              street_address: '912 Willow St',
              city: 'Arvada',
              state: 'Colorado',
              zip_code: '80003',
              applicant_bio: 'Because I am just awesome.',
              application_status: 'In Progress')
    charlie = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
    mina = Pet.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
    chloe = Pet.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
    vida = Pet.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

   visit "/applications/#{mike.id}"

   expect(page).to have_content("Search for pet by name")

   fill_in :search, with: "Charlie"
   click_on "Pet name search"

   expect(current_path).to eq("/applications/#{mike.id}")
   expect(page).to have_content(charlie.name)
 end

 it "Add a pet to an Application" do

   shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
   mike = Application.create!(
             name: 'Mike Dao',
             street_address: '245 Maple St',
             city: 'Centennial',
             state: 'Colorado',
             zip_code: '80112',
             applicant_bio: 'My dog needs another to chase up trees.',
             application_status: 'In Progress')
   chris = Application.create!(
             name: 'Chris Simmons',
             street_address: '533 Oak St',
             city: 'Columbus',
             state: 'Ohio',
             zip_code: '43004',
             applicant_bio: 'Because how much more work could a third cat be?',
             application_status: 'In Progress')
   dani = Application.create!(
             name: 'Dani Coleman',
             street_address: '912 Willow St',
             city: 'Arvada',
             state: 'Colorado',
             zip_code: '80003',
             applicant_bio: 'Because I am just awesome.',
             application_status: 'In Progress')
   charlie = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
   mina = Pet.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
   chloe = Pet.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
   vida = Pet.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

   visit "/applications/#{mike.id}"
   fill_in :search, with: "Charlie"
   click_on "Pet name search"
   click_on "Adopt #{charlie.name}"

   expect(current_path).to eq("/applications/#{mike.id}")
   expect(page).to have_content(charlie.name)
 end

 xit "Submit an Application" do

   shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
   mike = Application.create!(
             name: 'Mike Dao',
             street_address: '245 Maple St',
             city: 'Centennial',
             state: 'Colorado',
             zip_code: '80112',
             applicant_bio: 'My dog needs another to chase up trees.',
             application_status: 'In Progress')
   chris = Application.create!(
             name: 'Chris Simmons',
             street_address: '533 Oak St',
             city: 'Columbus',
             state: 'Ohio',
             zip_code: '43004',
             applicant_bio: 'Because how much more work could a third cat be?',
             application_status: 'In Progress')
   dani = Application.create!(
             name: 'Dani Coleman',
             street_address: '912 Willow St',
             city: 'Arvada',
             state: 'Colorado',
             zip_code: '80003',
             applicant_bio: 'Because I am just awesome.',
             application_status: 'In Progress')
   charlie = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
   mina = Pet.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
   chloe = Pet.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
   vida = Pet.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

   app_pet_1 = ApplicationPet.create!(application: mike, pet: charlie)

   visit "/applications/#{mike.id}"
   fill_in :search, with: "Charlie"
   click_on "Pet name search"
   click_on "Adopt this pet"

   expect(current_path).to eq("/applications/#{mike.id}")
   expect(page).to have_content("Why I would be a good owner:")

   fill_in :potential_owner_statement, with: "I like dogs a lot."
   click_on "Submit Application"

   expect(current_path).to eq("/applications/#{mike.id}")
   expect(page).to have_content("Application Status: Pending")

 end

end
