require 'rails_helper'

RSpec.describe Applicant do
    describe 'applicant#apply' do
    it 'displays the link to fill out the application from Application#form page' do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    applicant_1 = Applicant.create!(name: 'Mary Smith', street_address: '123 W Lost Ln', city: 'Denver', state: 'CO', zip_code: '80239', description: 'Words that describe')
    pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"

    click_link("Start an Application", match: :first)

    expect(current_path).to eq("/applicants/apply")

    fill_in 'Name', with: "#{applicant_1.name}", exact: true
    fill_in 'Street address', with: "#{applicant_1.street_address}", exact: true
    fill_in 'City', with: "#{applicant_1.city}", exact: true
    fill_in 'State', with: "#{applicant_1.state}", exact: true
    fill_in 'Zip code', with: "#{applicant_1.zip_code}", exact: true
    fill_in 'Description', with: "#{applicant_1.description}", exact: true

    click_on('Submit')

    expect(current_path).to eq("/applicants/#{applicant_1.id}")
    expect(page).to have_content('Mary Smith')
    expect(page).to have_content('123 W Lost Ln')
    expect(page).to have_content('Denver')
    expect(page).to have_content('CO')
    expect(page).to have_content('80239')
    expect(page).to have_content('Words that describe')
    expect(page).to have_content('In Progress')
    end
end