require 'rails_helper'

RSpec.describe 'new application page', type: :feature do 

  it 'US25: can create and submit a new application' do
    visit '/applicants/new'
    
    fill_in 'Name', with: 'Oliver Smudger'
    fill_in 'Street address', with: '1234 N Random Avenue'
    fill_in 'City', with: 'Tucson'
    fill_in 'State', with: 'Arizona'
    fill_in 'Zip code', with: '12345'

    expect(page).to have_button('Submit')
    click_button('Submit')     

    expect(page).to have_content('Oliver Smudger')
    expect(page).to have_content('1234 N Random Avenue')
    expect(page).to have_content('Tucson')
    expect(page).to have_content('Arizona')
    expect(page).to have_content('12345')
    expect(page).to have_content('N/A')
    expect(page).to have_content('In Progress')
  end
end

   

  #  shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
  #   pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
  #   pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
  #   applicant = Applicant.create!(name: 'Oliver Smudger', 
  #                                 street_address: '1234 N Random Avenue', 
  #                                 city: 'Tucson', 
  #                                 state: 'Arizona', 
  #                                 zip_code: '12345',
  #                                 description: 'I have a big yard and work from home.',
  #                                 application_status: 'In Progress'
                                # )