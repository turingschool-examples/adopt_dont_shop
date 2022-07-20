require 'rails_helper'

RSpec.describe 'the applicant show page', type: :feature do 
  
  it 'US26: shows the applicant and their attributes'  do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'Text',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/applicants/#{applicant.id}"
                              
    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(pet.name)
    expect(page).to have_content(applicant.application_status)
  end 

  it 'US26: can list all the pets an application is for & links to pets show page' do
     applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'N/A',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = applicant.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
   
    visit "/applicants/#{applicant.id}"
    
    expect(page).to have_content(applicant.pets.first.name)
    expect(page).to have_link('Scooby')

    click_link('Scooby')
    
    expect(current_path).to eq("/pets/#{pet.id}")
  end

  it 'US23: can search for a pet by name' do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'N/A',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/applicants/#{applicant.id}"
    
    expect(page).to have_content('Add a Pet to Application')

    fill_in 'pet_name', with: 'Lucille Bald'
    expect(page).to have_button('Submit')
    click_button('Submit')  

    expect(current_path).to eq("/applicants/#{applicant.id}")
    expect(page).to have_content('Lucille Bald')
    expect(page).to_not have_content('Scooby')
  end

  it 'US22: can add a pet to an application' do   
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'N/A',
                                  application_status: 'In Progress'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/applicants/#{applicant.id}"

    expect(page).to have_content('Add a Pet to Application')

    fill_in 'pet_name', with: 'Scooby'

    expect(page).to have_button('Submit')
    click_button('Submit')  

    expect(current_path).to eq("/applicants/#{applicant.id}")
    expect(page).to have_content('Scooby')
    expect(page).to have_button('Adopt this Pet')
    click_button('Adopt this Pet')  

    expect(current_path).to eq("/applicants/#{applicant.id}") 
  end

  it 'US21: can submit an application if pets are added' do 
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

    expect(page).to have_content('Add a Pet to Application')
    fill_in 'pet_name', with: 'Lucille Bald'
    expect(page).to have_button('Submit')
    click_button ('Submit')

    expect(page).to have_content('Lucille Bald')
    expect(page).to have_button('Adopt this Pet')
    click_button('Adopt this Pet')
   
    expect(page).to have_content('Submit my application')

    fill_in 'description', with: applicant.description
    expect(page).to have_button('Submit my application')
    click_button('Submit my application')  

    expect(page).to have_content('Lucille Bald')
    expect(page).to have_content('Pending')
  end

  it 'US20: cannot submi an application with no pets added' do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'I have a big yard and work from home.',
                                  application_status: 'In Progress'
                                  )
                            
    visit "/applicants/#{applicant.id}"
                                 
    expect(page).to have_content('Add a Pet to Application')
    expect(page).to_not have_content('Submit my application')                              
    expect(page).to_not have_button('Submit my application')
  end

  it 'US19: it can find partial matches for pet names' do
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

    expect(page).to have_content('Add a Pet to Application')

    fill_in 'pet_name', with: 'Sco'

    expect(page).to have_button('Submit')
    click_button('Submit')  

    expect(page).to have_content('Scooby')
    expect(page).to have_button('Adopt this Pet')
  end

  it 'US18: the search is case insensitive' do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'N/A',
                                  application_status: 'In Progress'
                                  )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/applicants/#{applicant.id}"

    expect(page).to have_content('Add a Pet to Application')

    fill_in 'pet_name', with: 'LuciLLE bald'

    expect(page).to have_button('Submit')
    click_button('Submit')  

    expect(page).to have_content('Lucille Bald')
    expect(page).to have_button('Adopt this Pet')
  end
end
 