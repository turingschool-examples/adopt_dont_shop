require 'rails_helper'

RSpec.describe 'admin application show page' do 

  it 'US15: can approve a pet for adoption' do 
    applicant = Applicant.create!(name: 'Oliver Smudger', 
                                  street_address: '1234 N Random Avenue', 
                                  city: 'Tucson', 
                                  state: 'Arizona', 
                                  zip_code: '12345',
                                  description: 'Text',
                                  application_status: 'Pending'
                                )
    shelter = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = applicant.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/admin/applicants/#{applicant.id}"

    expect(page).to have_button('Approve application')

    within "#pets-#{pet_1.id}" do 
    click_button('Approve application') 
    end

    within "#pets-#{pet_2.id}" do 
    click_button('Approve application') 
    end

    expect(current_path).to eq("/admin/applicants/#{applicant.id}")
    expect(page).to_not have_content('Approve application')
    expect(page).to have_content('Approved')
    save_and_open_page
  end
end
