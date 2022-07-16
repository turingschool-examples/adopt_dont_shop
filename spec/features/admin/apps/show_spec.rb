require 'rails_helper'

RSpec.describe 'admin app show' do

  # Approving a Pet for Adoption

  # As a visitor
  # When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved

  it 'can approve a pet for adoption' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "in progress")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_2, app: app_1)

    visit "/admin/apps/#{app_1.id}"
    within "#pet_#{pet_1.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")

    within "#pet_#{pet_1.id}" do
      expect(page).to_not have_button('Approve')
      expect(page).to_not have_button('Reject')
      expect(page).to have_content('Approved')
    end
  end

  # Rejecting a Pet for Adoption

  # As a visitor
  # When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to reject the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I rejected, I do not see a button to approve or reject this pet
  # And instead I see an indicator next to the pet that they have been rejected

  it 'can reject a pet for adoption' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "in progress")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_2, app: app_1)

    visit "/admin/apps/#{app_1.id}"
    within "#pet_#{pet_1.id}" do
      click_button 'Reject'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")

    within "#pet_#{pet_1.id}" do
      expect(page).to_not have_button('Reject')
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Rejected')
    end
  end

  # Approved/Rejected Pets on one Application do not affect other Applications

  # As a visitor
  # When there are two applications in the system for the same pet
  # When I visit the admin application show page for one of the applications
  # And I approve or reject the pet for that application
  # When I visit the other application's admin show page
  # Then I do not see that the pet has been accepted or rejected for that application
  # And instead I see buttons to approve or reject the pet for this specific application

  it 'approval/rejection doesnt affect other applications for that same pet' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "in progress")
    app_2 = App.create!(name: "John", address: "22 Dexter St", city: "Denver", state: "CO", zip: "80200", description: "123", status: "in progress")
    app_3 = App.create!(name: "Terry", address: "8080 Elm St", city: "Boulder", state: "CO", zip: "80222", description: "LOL", status: "in progress")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_1, app: app_2)
    PetApp.create!(pet: pet_1, app: app_3)
    
    
    visit "/admin/apps/#{app_1.id}"
    within "#pet_#{pet_1.id}" do
      click_button 'Accept'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")

    within "#pet_#{pet_1.id}" do
      expect(page).to_not have_button('Reject')
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Accepted')
    end

    visit "/admin/apps/#{app_2.id}"
    within "#pet_#{pet_1.id}" do
      click_button 'Reject'
    end

    expect(current_path).to eq("/admin/apps/#{app_2.id}")

    within "#pet_#{pet_1.id}" do
      expect(page).to_not have_button('Reject')
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Rejected')
    end

    visit "/admin/apps/#{app_3.id}"
    within "#pet_#{pet_1.id}" do
      click_button 'Reject'
    end

    expect(current_path).to eq("/admin/apps/#{app_3.id}")

    within "#pet_#{pet_1.id}" do
      expect(page).to_not have_button('Reject')
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Rejected')
    end
  end
end