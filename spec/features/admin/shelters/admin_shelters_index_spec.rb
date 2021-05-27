require 'rails_helper'

describe 'admin shelters index' do
  before :each do
    @denver = Shelter.create!(name: 'Denver Pet Shelter', city: 'Denver', rank: 1, foster_program: true)
    @greely = Shelter.create!(name: 'Greely Dumb Friends League', city: 'Greelyr', rank: 2, foster_program: true)
    @eagle = Shelter.create!(name: 'Eagle Pet Sanctuary', city: 'Eagle', rank: 3, foster_program: true)
    visit 'admin/shelters'
  end

  it 'lists all shelters in reverse alphabetical order' do
    expect('Greely Dumb Friends League').to appear_before('Eagle Pet Sanctuary')
    expect('Eagle Pet Sanctuary').to appear_before('Denver Pet Shelter')
  end

  it 'lists shelters with pending applications' do
    @pet_1 = @denver.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @eagle.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    petition = Petition.create!(name: 'Ted Leo',
                                street_address: '123 Pharmacist Ln',
                                city: 'Denver',
                                state: 'Co',
                                zipcode: 12_345,
                                goodhome: 'Lurv Fluffers',
                                status: 'Pending')
    pet_petition = PetPetition.create!(petition: petition, pet: @pet_1)
    pet_petition2 = PetPetition.create!(petition: petition, pet: @pet_2)

    expect(page).to have_content('Denver Pet Shelter')
    expect(page).to have_content('Eagle Pet Sanctuary')
  end

  it 'lists shelters with pending applications in alphabetical order' do
    @pet_1 = @denver.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @eagle.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    petition = Petition.create!(name: 'Ted Leo',
                                street_address: '123 Pharmacist Ln',
                                city: 'Denver',
                                state: 'Co',
                                zipcode: 12_345,
                                goodhome: 'Lurv Fluffers',
                                status: 'Pending')
    pet_petition = PetPetition.create!(petition: petition, pet: @pet_1)
    pet_petition2 = PetPetition.create!(petition: petition, pet: @pet_2)

    within(".right_list", text: 'With Pending Applications') 
    expect('Eagle Pet Sanctuary').to appear_before('Denver Pet Shelter')
  end

  it 'contains links to each shelter by name' do
    expect(page).to have_link('Denver Pet Shelter', :href => "/admin/shelters/#{@denver.id}")
    expect(page).to have_link('Eagle Pet Sanctuary', :href => "/admin/shelters/#{@eagle.id}")
  end
end
