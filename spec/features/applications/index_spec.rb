require 'rails_helper'

RSpec.describe 'the application index' do
  it 'is a list of all applicants and their attributes' do
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

    pet = mike.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
    pet2 = dani.pets.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
    pet3 = chris.pets.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
    pet4 = dani.pets.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

    visit '/applications'

    expect(page).to have_content(mike.name)
    expect(page).to have_content(chris.name)
    expect(page).to have_content(dani.name)
  end
end
