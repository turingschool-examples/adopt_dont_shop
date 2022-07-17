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

  it 'has a reject button for every pet' do
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
    lucille = application_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
    lobster = application_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)

    visit "/admin/applications/#{application_1.id}"
    
    within ("#pet-#{lucille.id}") do
      click_button('Reject Application')
      expect(page).to have_content(lucille.name)
      expect(page).to have_no_button('Reject Application')
      expect(page).to have_content('Rejected')
    end
    
    within ("#pet-#{lobster.id}") do
      expect(page).to have_button('Reject Application')
      expect(page).to have_content(lobster.name)
    end
  end

  it 'accepting an application on one app does not impact the pet on another app' do
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
    application_2 = Application.create!(name: "Cindy Smith", street: "727 Lane road", city: "Rockville", state: "CA", zipcode: 95148, status:"Pending", description:"I have a big yard them to run all day")
    lucille = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
    lobster = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)
    PetApplication.create!(pet: lucille, application: application_1)
    PetApplication.create!(pet: lobster, application: application_1)
    PetApplication.create!(pet: lucille, application: application_2)

    visit "/admin/applications/#{application_1.id}"

    within ("#pet-#{lucille.id}") do
      click_button('Approve Application')
      expect(page).to have_no_button('Approve Application')
      expect(page).to have_content('Approved')
    end

    visit "/admin/applications/#{application_2.id}"

    within ("#pet-#{lucille.id}") do
      expect(page).to have_content(lucille.name)
      expect(page).to have_button('Approve Application')
    end
  end

  it 'rejecting an application on one app does not impact the pet on another app' do
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
    application_2 = Application.create!(name: "Cindy Smith", street: "727 Lane road", city: "Rockville", state: "CA", zipcode: 95148, status:"Pending", description:"I have a big yard them to run all day")
    lucille = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: aurora.id)
    lobster = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: aurora.id)
    PetApplication.create!(pet: lucille, application: application_1)
    PetApplication.create!(pet: lobster, application: application_1)
    PetApplication.create!(pet: lucille, application: application_2)

    visit "/admin/applications/#{application_1.id}"
    
    within ("#pet-#{lucille.id}") do
      click_button('Reject Application')
      expect(page).to have_no_button('Reject Application')
      expect(page).to have_content('Rejected')
    end

    visit "/admin/applications/#{application_2.id}"

    within ("#pet-#{lucille.id}") do
      expect(page).to have_content(lucille.name)
      expect(page).to have_button('Reject Application')
    end
  end
end