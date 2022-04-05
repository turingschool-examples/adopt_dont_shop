require 'rails_helper'

RSpec.describe 'the admin application show page' do
  it 'shows the application name and full address' do
    shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
    pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress',
    )

    visit "/applications/#{application.id}"
    fill_in 'Pets', with: "Joey"
    click_button "Search"
    expect(page).to have_link("Joey")
    click_button 'Adopt Joey'

    visit "/admin/applications/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(pet1.name)
    save_and_open_page
    click_button "Approve"
    expect(page).to_not have_content("Approve")
    expect(page).to have_content(pet1.name)
    save_and_open_page

  end

  # it 'shows the number of pets in the shelter' do
  #   shelter1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   shelter2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
  #   luna = Pet.create!(name: 'luna', age: 1, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
  #   booth = Pet.create!(name: 'booth', age: 11, breed: 'Cat', adoptable: true, shelter_id: shelter2.id)
  #   archie = Pet.create!(name: 'archie', age: 4, breed: 'Dog', adoptable: true, shelter_id: shelter1.id)
  #   archie = Pet.create!(name: 'archie', age: 4, breed: 'Dog', adoptable: false, shelter_id: shelter1.id)
  #   rocky = Pet.create!(name: 'rocky', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter1.id)
  #   opa = Pet.create!(name: 'Opa', age: 2, breed: 'Hamster', adoptable: true, shelter_id: shelter2.id)
  #
  #   visit "/admin/shelters/#{shelter1.id}"
  #   expect(page).to have_content("Statistics")
  #   expect(page).to have_content("Adoptable Pet Count: 2")
  #
  #   visit "/admin/shelters/#{shelter2.id}"
  #   expect(page).to have_content("Statistics")
  #   expect(page).to have_content("Adoptable Pet Count: 3")
  # end
end
