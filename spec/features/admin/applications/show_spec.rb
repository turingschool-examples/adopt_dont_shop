require 'rails_helper'

RSpec.describe 'the admin application show page' do
  it 'allows admin to approve a specific pet for adoption' do
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

    click_button "Approve"
    expect(page).to_not have_content("Approve")
    expect(page).to have_content(pet1.name)

  end

  it 'allows admin to reject a specific pet for adoption' do
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

    click_button "Reject"
    expect(page).to_not have_content("Approve")
    expect(page).to_not have_content("Reject")
    expect(page).to have_content("#{pet1.name} rejected")

  end

  it 'allows admin to reject a specific pet for adoption' do
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
    application2 = Application.create!(name: 'Antonio',
      street_address: '100 Happy Valley',
      city: 'Orinda',
      state: 'CA',
      zipcode: '94207',
      description: 'Person all day',
      status: 'In Progress',
    )
    app_pet_1 = ApplicationPet.create!(application_id: application.id, pet_id: pet1.id)
    app_pet_2 = ApplicationPet.create!(application_id: application2.id, pet_id: pet1.id)

    visit "/admin/applications/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(pet1.name)

    click_button "Reject"
    expect(page).to_not have_content("Approve")
    expect(page).to_not have_content("Reject")
    expect(page).to have_content("#{pet1.name} rejected")

    visit "/admin/applications/#{application2.id}"
    expect(page).to have_content(application2.name)
    expect(page).to have_content(pet1.name)

    click_button "Reject"
    expect(page).to_not have_content("Approve")
    expect(page).to_not have_content("Reject")
    expect(page).to have_content("#{pet1.name} rejected")

  end
end
