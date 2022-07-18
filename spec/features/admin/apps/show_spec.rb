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
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
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
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
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
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
    app_2 = App.create!(name: "John", address: "22 Dexter St", city: "Denver", state: "CO", zip: "80200", description: "123", status: "pending")
    app_3 = App.create!(name: "Terry", address: "8080 Elm St", city: "Boulder", state: "CO", zip: "80222", description: "LOL", status: "pending")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    # pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    # pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_1, app: app_2)
    PetApp.create!(pet: pet_1, app: app_3)
    
    
    visit "/admin/apps/#{app_1.id}"
    within "#pet_#{pet_1.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")

    within "#pet_#{pet_1.id}" do
      expect(page).to_not have_button('Reject')
      expect(page).to_not have_button('Approve')
      expect(page).to have_content('Approved')
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

  # All Pets Accepted on an Application

  # As a visitor
  # When I visit an admin application show page
  # And I approve all pets for an application
  # Then I am taken back to the admin application show page
  # And I see the application's status has changed to "Approved"

  it 'can changed app status to accepted when all pets approved' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_2, app: app_1)
    PetApp.create!(pet: pet_3, app: app_1)

    visit "/admin/apps/#{app_1.id}"
    expect(page).to have_content('Status: pending')
    
    within "#pet_#{pet_1.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: pending')

    within "#pet_#{pet_2.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: pending')

    within "#pet_#{pet_3.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: accepted')
  end

  # One or More Pets Rejected on an Application

  # As a visitor
  # When I visit an admin application show page
  # And I reject one or more pets for the application
  # And I approve all other pets on the application
  # Then I am taken back to the admin application show page
  # And I see the application's status has changed to "Rejected"

  it 'can changed app status to rejected when any pets rejected' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_2, app: app_1)
    PetApp.create!(pet: pet_3, app: app_1)

    visit "/admin/apps/#{app_1.id}"
    expect(page).to have_content('Status: pending')
    
    within "#pet_#{pet_1.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: pending')

    within "#pet_#{pet_2.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: pending')

    within "#pet_#{pet_3.id}" do
      click_button 'Reject'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: rejected')
  end

  # Application Approval makes Pets not adoptable

  # As a visitor
  # When I visit an admin application show page
  # And I approve all pets on the application
  # And when I visit the show pages for those pets
  # Then I see that those pets are no longer "adoptable"

  it 'can make pet unadoptable upon app accepted' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_2, app: app_1)

    visit "/admin/apps/#{app_1.id}"
    expect(page).to have_content('Status: pending')
    
    within "#pet_#{pet_1.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: pending')

    within "#pet_#{pet_2.id}" do
      click_button 'Approve'
    end

    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: accepted')

    expect(pet_1.reload.adoptable).to be(false)
    expect(pet_2.reload.adoptable).to be(false)
    
    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("Adoptable: false")

    visit "/pets/#{pet_2.id}"
    expect(page).to have_content("Adoptable: false")
  end
  
  it 'only lets pets have one approved application at a time' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
    app_2 = App.create!(name: "John", address: "22 Dexter St", city: "Denver", state: "CO", zip: "80200", description: "123", status: "pending")
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    
    PetApp.create!(pet: pet_1, app: app_1)
    PetApp.create!(pet: pet_1, app: app_2)
    
    visit "/admin/apps/#{app_1.id}"
    expect(page).to have_content('Status: pending')
    
    visit "/admin/apps/#{app_2.id}"
    expect(page).to have_content('Status: pending')
    
    within "#pet_#{pet_1.id}" do
      click_button 'Approve'
    end
    
    expect(current_path).to eq("/admin/apps/#{app_2.id}")
    expect(page).to have_content('Status: accepted')
    
    visit "/admin/apps/#{app_1.id}"
    
    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to have_content('Status: pending')
    
    within "#pet_#{pet_1.id}" do
      expect(page).to have_content("Already approved")
      expect(page).to_not have_button("Approve")
      expect(page).to have_button("Reject")
      click_button 'Reject'
    end
    
    expect(current_path).to eq("/admin/apps/#{app_1.id}")
    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("Rejected")
  end
end

# Pets can only have one approved application on them at any time

# As a visitor
# When a pet has an "Approved" application on them
# And when the pet has a "Pending" application on them
# And I visit the admin application show page for the pending application
# Then next to the pet I do not see a button to approve them
# And instead I see a message that this pet has been approved for adoption
# And I do see a button to reject them