require 'rails_helper'

RSpec.describe 'search' do
  let!(:shelter) { Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:pe_1) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_2) { Pet.create!(name: 'Scoobyroo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_3) { Pet.create!(name: 'Scoo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_4) { Pet.create!(name: 'Jerry', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345", status: "In Progress" ) }
  it 'can search for a pet and display it on the page' do
    visit "/applications/#{application.id}"

    expect(page).to have_content('search by Pets:')

    fill_in 'search', with: 'Scooby'
    click_button('Add a Pet to this Application')

    expect(page).to have_content('Scooby')
  end
  
  it 'can get a partial match' do
    visit "/applications/#{application.id}"

    fill_in 'search', with: 'Scoob'
    click_button('Add a Pet to this Application')

    expect(page).to have_content("Scooby")
    expect(page).to have_content("Scoobyroo")
    expect(page).to_not have_content("Jerry")
  end

  it 'can search case insensitive' do
    visit "/applications/#{application.id}"

    fill_in 'search', with: 'ScOoBy'
    click_button('Add a Pet to this Application')
    
    expect(page).to have_content('Scooby')
  end
  
end