require 'rails_helper'

RSpec.describe 'Application Show', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love cats so I want to adopt them", status: 'In Progress') }
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}
  let!(:pet1) {Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'George Hairlesson', shelter_id: shelter_3.id)}
  let!(:pet2) {Pet.create!(adoptable: false, age: 2, breed: 'american shorthair', name: 'Furry', shelter_id: shelter_3.id)}

  let!(:pet1_application) {PetApplication.create!(application_id: applicant1.id, pet_id: pet1.id)}
  let!(:pet2_application) {PetApplication.create!(application_id: applicant1.id, pet_id: pet2.id)}
  


  it 'I see applicants name, full address, descripition, name of all pets applying for and status'  do
    visit "/applications/#{applicant1.id}" 
    save_and_open_page

    expect(page).to have_content('Jamison Ordway') 
    expect(page).to have_content('123 Cat St') 
    expect(page).to have_content("I love cats so I want to adopt them") 
    expect(page).to have_content('In Progress') 
    expect(page).to have_link(pet1.name)
    expect(page).to have_link(pet2.name)
  end
end