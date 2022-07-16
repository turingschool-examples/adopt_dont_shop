require 'rails_helper'

RSpec.describe 'admin application index page' do
  it 'has an approve button for every pet' do
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
    lucille = application_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
    lobster = application_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)

    visit "/admin/applications/#{application_1.id}"

    within ("#pet-#{lucille.id}") do
      expect(page).to have_button('Approve Application')
      expect(page).to have_content(lucille.name)
    end

    within ("#pet-#{lobster.id}") do
      expect(page).to have_button('Approve Application')
      expect(page).to have_content(lobster.name)
    end
  end

  it 'has an approve button for every pet' do
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
    lucille = application_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
    lobster = application_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)

    visit "/admin/applications/#{application_1.id}"

    within ("#pet-#{lucille.id}") do
      click_button('Approve Application')
      expect(page).to have_content(lucille.name)
      expect(page).to have_no_button('Approve Application')
      expect(page).to have_content('Approved')
    end

    within ("#pet-#{lobster.id}") do
      expect(page).to have_button('Approve Application')
      expect(page).to have_content(lobster.name)
    end
  end
end