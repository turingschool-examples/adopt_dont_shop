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
    expect(page).to have_content('Mr. Pirate -- tuxedo shorthair: 5 years old.')
    expect(page).to have_content('Clawdia -- shorthair: 3 years old.')
  end

  it 'contains a button next to each of those pets to approve or reject application' do
    expect(page).to have_button('Approve Ted Leo for Mr. Pirate')
    expect(page).to have_button('Reject Ted Leo for Mr. Pirate')
    expect(page).to have_button('Approve Ted Leo for Clawdia')
    expect(page).to have_button('Reject Ted Leo for Clawdia')
  end

  it 'clicking approve approves a pet for adoption' do
    click_button('Approve Ted Leo for Mr. Pirate')

    expect(current_path).to eq "/admin/petitions/#{@petition.id}"
    expect(page).to have_content 'Application Status: Approved'
  end

  it 'clicking reject rejects the adoption' do
    click_button('Reject Ted Leo for Mr. Pirate')

    expect(current_path).to eq "/admin/petitions/#{@petition.id}"
    expect(page).to have_content 'Application Status: Rejected'
  end

  it 'clicking approve or reject removes button' do
    click_button('Approve Ted Leo for Mr. Pirate')
    click_button('Reject Ted Leo for Clawdia')

    expect(page).not_to have_button('Approve Ted Leo for Mr. Pirate')
    expect(page).not_to have_button('Reject Ted Leo for Mr. Pirate')
    expect(page).not_to have_button('Approve Ted Leo for Clawdia')
    expect(page).not_to have_button('Reject Ted Leo for Clawdia')
  end

  it 'clicking approve or reject does not affect other applications'
  #   click_button('Approve Ted Leo for Mr. Pirate')

    
  # end
end
