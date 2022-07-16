require 'rails_helper'

RSpec.describe 'the applicant show page', type: :feature do 
  
  it 'US26: shows the applicant and their attributes'  do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'I have a big yard and work from home.',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/applicants/#{applicant.id}"
                              
    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(applicant.description)
    expect(page).to have_content(applicant.application_status)
  end 

  it 'US26: can list all the pets an application is for & links to pets show page' do
     applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'I have a big yard and work from home.',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = applicant.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
   
    visit "/applicants/#{applicant.id}"
    
    expect(page).to have_content(applicant.pets.first.name)

    click_link('Scooby')
    
    expect(current_path).to eq("/pets/#{pet.id}")
  end
end