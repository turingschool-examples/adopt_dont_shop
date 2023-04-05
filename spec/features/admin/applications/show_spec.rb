require 'rails_helper'

RSpec.describe '/admin/application/:id', type: :feature do
  let!(:application_1) { Application.create!(name: 'Taylor', address: '123 Side St', city: 'Denver', state: 'CO', zip: '80202', description: 'I love animals', status: 1) }
  let!(:application_2) { Application.create!(name: 'Thomas', address: '456 Main St', city: 'Denver', state: 'CO', zip: '80123', description: 'I hate animals', status: 1) }
  
  let!(:shelter) { Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }

  let!(:bella) { shelter.pets.create!(name: 'Bella', age: 1, breed: 'Golden', adoptable: true) }
  let!(:rigby) { shelter.pets.create!(name: 'Rigby', age: 2, breed: 'Mix', adoptable: true) }
  let!(:luna) { shelter.pets.create!(name: 'Luna', age: 4, breed: 'Pitbull', adoptable: true) }

  let!(:pet_app_1) { PetApplication.create!(pet: bella, application: application_1) }
  let!(:pet_app_2) { PetApplication.create!(pet: rigby, application: application_1) }
  let!(:pet_app_3) { PetApplication.create!(pet: bella, application: application_2) }

  describe 'When I visit the admin applications show page' do
    it 'I see every pet that the application is for' do
      visit "/admin/applications/#{application_1.id}"
      expect(page).to have_content('Application Status: Pending')
      expect(page).to have_content('Bella')
      expect(page).to have_content('Rigby')
    end

    it 'I see a button next to each pet to approve the application for that pet' do
      visit "/admin/applications/#{application_1.id}"
      
      expect(page).to have_button('Approve Bella')
      expect(page).to have_button('Approve Rigby')
    end

    it 'I see a button next to each pet to reject the application for that pet' do
      visit "/admin/applications/#{application_1.id}"
      
      expect(page).to have_button('Reject Bella')
      expect(page).to have_button('Reject Rigby')
    end
  end

  describe 'When I click approve button for a pet' do
    it 'It displays Approved next to the pet and no buttons are displayed' do
      visit "/admin/applications/#{application_1.id}"

      click_button 'Approve Bella'
      
      expect(page).to have_content('Bella is Approved')
      expect(page).to_not have_button('Approve Bella')
    end
  end

  describe 'When I click reject button for a pet' do
    it 'It displays Rejected next to the pet and no buttons are displayed' do
      visit "/admin/applications/#{application_1.id}"
      
      click_button 'Reject Bella'
      
      expect(page).to have_content('Bella is Rejected')
      expect(page).to_not have_button('Reject Bella')
    end
  end

  describe 'When I click approve button for a pet with multiple applications' do
    it 'It displays an approved button next to the pet on the other application (after the previous application has already been aproved)' do
      visit "/admin/applications/#{application_1.id}"
      
      click_button 'Approve Bella'
      
      visit "/admin/applications/#{application_2.id}"
      
      expect(page).to have_button('Approve Bella')
    end
  end

  describe 'When you approve all pets for an application' do
    it 'the application now has a status of Approved' do
      visit "/admin/applications/#{application_1.id}"

      click_button 'Approve Bella'
      click_button 'Approve Rigby'

      expect(current_path).to eq("/admin/applications/#{application_1.id}")
      expect(page).to have_content('Application Status: Accepted')

      visit "/applications/#{application_1.id}"

      expect(page).to have_content('Status: Accepted')
    end

    it 'the adoptable attribute for each pet is changed to false' do
      visit "/pets/#{bella.id}"

      expect(page).to have_content(true)

      visit "/admin/applications/#{application_1.id}"

      click_button 'Approve Bella'
      click_button 'Approve Rigby'

      visit "/pets/#{bella.id}"

      expect(page).to have_content(false)

      visit "/pets/#{rigby.id}"

      expect(page).to have_content(false)
    end
  end

  describe 'When you reject one pet for an application' do
    it 'the application now has a status of Rejected' do
      visit "/admin/applications/#{application_1.id}"

      click_button 'Approve Bella'
      
      expect(page).to have_content('Application Status: Pending')

      click_button 'Reject Rigby'

      expect(current_path).to eq("/admin/applications/#{application_1.id}")
      expect(page).to have_content('Application Status: Rejected')
    end
  end

  describe 'If the same pet is on two different applications' do
    it 'When one application the pet is on is approved then the other application will show a message that the pet is already adopted' do
      visit "/admin/applications/#{application_1.id}"

      click_button 'Approve Bella'
      click_button 'Approve Rigby'
      visit "/admin/applications/#{application_2.id}"

      expect(page).to have_content('This pet has already been approved for adoption')
      expect(page).to have_button('Reject Bella')
    end
  end
end