require 'rails_helper'

describe 'admin petitions show' do
  before :each do
    @denver = Shelter.create!(name: 'Denver Pet Shelter', city: 'Denver', rank: 1, foster_program: true)
    @eagle = Shelter.create!(name: 'Eagle Pet Sanctuary', city: 'Eagle', rank: 3, foster_program: true)
    @pet_1 = @denver.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @eagle.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @petition = Petition.create!(name:'Ted Leo', 
                                street_address: '123 Pharmacist Ln', 
                                city: 'Denver', 
                                state: 'Co',
                                zipcode: 12345,
                                goodhome: 'Lurv Fluffers',
                                status: 'Pending')
    @pet_petition = PetPetition.create!(petition: @petition, pet:@pet_1)
    @pet_petition2 = PetPetition.create!(petition: @petition, pet:@pet_2)
    visit "/admin/petitions/#{@petition.id}"
  end

  it 'lists every pet associated with petition' do
    expect(page).to have_content('Mr. Pirate')
    expect(page).to have_content('Clawdia')
  end
end
