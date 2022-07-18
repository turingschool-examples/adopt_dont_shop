require 'rails_helper'

RSpec.describe 'application show page' do
  it 'shows the applicant and all of their attributes' do
    mike = Application.create!(
                  name: 'Mike Dao',
                  street_address: '245 Maple St',
                  city: 'Centennial',
                  state: 'Colorado',
                  zip_code: '80112',
                  applicant_bio: 'My dog needs another to help chase bears up trees.',
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

    visit "/applications/#{mike.id}"

    expect(page).to have_content('Name: Mike Dao')
    expect(page).to have_content('Address: 245 Maple St')
    expect(page).to have_content('Applicant Bio: My dog needs another to help chase bears up trees.')
    expect(page).to have_content('Application Status: In Progress')
    expect(page).to_not have_content('Name: Chris Simmons')
    expect(page).to_not have_content('Name: Dani Coleman')

    visit "/applications/#{chris.id}"

    expect(page).to have_content('Name: Chris Simmons')
    expect(page).to have_content('Address: 533 Oak St')
    expect(page).to have_content('Applicant Bio: Because how much more work could a third cat be?')
    expect(page).to have_content('Application Status: In Progress')
    expect(page).to_not have_content('Name: Mike Dao')
    expect(page).to_not have_content('Name: Dani Coleman')

    visit "/applications/#{dani.id}"

    expect(page).to have_content('Name: Dani Coleman')
    expect(page).to have_content('Address: 912 Willow St')
    expect(page).to have_content('Applicant Bio: Because I am just awesome.')
    expect(page).to have_content('Application Status: In Progress')
    expect(page).to_not have_content('Name: Chris Simmons')
    expect(page).to_not have_content('Name: Mike Dao')
  end

  it 'is shows the names of all pets in which the applicant is applying' do
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    mike = Application.create!(
                  name: 'Mike Dao',
                  street_address: '245 Maple St',
                  city: 'Centennial',
                  state: 'Colorado',
                  zip_code: '80112',
                  applicant_bio: 'My dog needs another to help chase bears up trees.',
                  application_status: 'In Progress')
    brutus = Pet.create!(adoptable: true, age: 3, breed: 'Karelian', name: 'Brutus', shelter_id: aurora.id)
    mike_brutus = ApplicationPet.create!(application_id: mike.id, pet_id: brutus.id)

    summit = Shelter.create!(name: 'Summit County', city: 'Akron, OH', foster_program: false, rank: 8)
    chris = Application.create!(
                  name: 'Chris Simmons',
                  street_address: '533 Oak St',
                  city: 'Columbus',
                  state: 'Ohio',
                  zip_code: '43004',
                  applicant_bio: 'Because how much more work could a third cat be?',
                  application_status: 'In Progress')
    chloe = Pet.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: summit.id)
    chris_chloe = ApplicationPet.create!(application_id: chris.id, pet_id: chloe.id)

    foothills = Shelter.create!(name: 'Foothills Animal Shelter', city: 'Golden, CO', foster_program: false, rank: 9)
    bwf = Shelter.create!(name: 'Bunny World Foundation', city: 'Los Angeles, CA', foster_program: true, rank: 9)
    dani = Application.create!(
                  name: 'Dani Coleman',
                  street_address: '912 Willow St',
                  city: 'Arvada',
                  state: 'Colorado',
                  zip_code: '80003',
                  applicant_bio: 'Because I am just awesome.',
                  application_status: 'In Progress')
    mina = Pet.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: bwf.id)
    vida = Pet.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: foothills.id)
    dani_mina = ApplicationPet.create!(application_id: dani.id, pet_id: mina.id)
    dani_vida = ApplicationPet.create!(application_id: dani.id, pet_id: vida.id)

    visit "/applications/#{mike.id}"

    expect(page).to have_content('Name: Mike Dao')
    expect(page).to have_content('Address: 245 Maple St')
    expect(page).to have_link('Brutus')
    expect(page).to_not have_content('Name: Chris Simmons')
    expect(page).to_not have_content('Name: Dani Coleman')

    visit "/applications/#{chris.id}"

    expect(page).to have_content('Name: Chris Simmons')
    expect(page).to have_link('Chloe')
    expect(page).to_not have_content('Name: Mike Dao')
    expect(page).to_not have_content('Name: Dani Coleman')

    visit "/applications/#{dani.id}"

    expect(page).to have_content('Name: Dani Coleman')
    expect(page).to have_link('Mina')
    expect(page).to have_link('Vida')
    expect(page).to_not have_content('Name: Chris Simmons')
    expect(page).to_not have_content('Name: Mike Dao')
  end

  it 'can search for pets for an application' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    mike = Application.create!(
              name: 'Mike Dao',
              street_address: '245 Maple St',
              city: 'Centennial',
              state: 'Colorado',
              zip_code: '80112',
              applicant_bio: 'My dog needs another to help chase bears up trees.',
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

 it "adds a pet to an application" do
   aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
   mike = Application.create!(
                 name: 'Mike Dao',
                 street_address: '245 Maple St',
                 city: 'Centennial',
                 state: 'Colorado',
                 zip_code: '80112',
                 applicant_bio: 'My dog needs another to help chase bears up trees.',
                 application_status: 'In Progress')
   brutus = Pet.create!(adoptable: true, age: 3, breed: 'Karelian', name: 'Brutus', shelter_id: aurora.id)

   summit = Shelter.create!(name: 'Summit County', city: 'Akron, OH', foster_program: false, rank: 8)
   chris = Application.create!(
                 name: 'Chris Simmons',
                 street_address: '533 Oak St',
                 city: 'Columbus',
                 state: 'Ohio',
                 zip_code: '43004',
                 applicant_bio: 'Because how much more work could a third cat be?',
                 application_status: 'In Progress')
   chloe = Pet.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: summit.id)

   foothills = Shelter.create!(name: 'Foothills Animal Shelter', city: 'Golden, CO', foster_program: false, rank: 9)
   bwf = Shelter.create!(name: 'Bunny World Foundation', city: 'Los Angeles, CA', foster_program: true, rank: 9)
   dani = Application.create!(
                 name: 'Dani Coleman',
                 street_address: '912 Willow St',
                 city: 'Arvada',
                 state: 'Colorado',
                 zip_code: '80003',
                 applicant_bio: 'Because I am just awesome.',
                 application_status: 'In Progress')
   mina = Pet.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: bwf.id)
   vida = Pet.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: foothills.id)

   visit "/applications/#{mike.id}"
   fill_in :search, with: 'Brutus'
   click_on 'Pet name search'

   expect(page).to have_content('Brutus')

   click_on "Adopt #{brutus.name}"

   expect(current_path).to eq("/applications/#{mike.id}")
   expect(page).to have_link('Brutus')

   visit "/applications/#{chris.id}"
   fill_in :search, with: 'Chloe'
   click_on "Pet name search"

   expect(page).to have_content('Chloe')

   click_on "Adopt #{chloe.name}"

   expect(current_path).to eq("/applications/#{chris.id}")
   expect(page).to have_link('Chloe')

   visit "/applications/#{dani.id}"
   fill_in :search, with: "Mina"
   click_on "Pet name search"

   expect(page).to have_content('Mina')

   click_on "Adopt #{mina.name}"

   expect(current_path).to eq("/applications/#{dani.id}")
   expect(page).to have_link('Mina')

   fill_in :search, with: "Vida"
   click_on "Pet name search"

   expect(page).to have_link('Mina')
   expect(page).to have_content('Vida')

   click_on "Adopt #{vida.name}"

   expect(current_path).to eq("/applications/#{dani.id}")
   expect(page).to have_link('Mina')
   expect(page).to have_link('Vida')
 end

 xit "Submit an Application" do
   shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
   mike = Application.create!(
             name: 'Mike Dao',
             street_address: '245 Maple St',
             city: 'Centennial',
             state: 'Colorado',
             zip_code: '80112',
             application_status: 'In Progress')
   chris = Application.create!(
             name: 'Chris Simmons',
             street_address: '533 Oak St',
             city: 'Columbus',
             state: 'Ohio',
             zip_code: '43004',
             application_status: 'In Progress')
   dani = Application.create!(
             name: 'Dani Coleman',
             street_address: '912 Willow St',
             city: 'Arvada',
             state: 'Colorado',
             zip_code: '80003',
             application_status: 'In Progress')
   mina = Pet.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
   chloe = Pet.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
   vida = Pet.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)
   brutus = Pet.create!(adoptable: true, age: 3, breed: 'Karelian', name: 'Brutus', shelter_id: shelter.id)
   mike_brutus = ApplicationPet.create!(application_id: mike.id, pet_id: brutus.id)

   visit "/applications/#{mike.id}"
   fill_in :search, with: "Brutus"
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
