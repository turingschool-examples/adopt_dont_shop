# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the veterinarian update' do
  it 'shows the veterinarian edit form' do
    vet_office = VeterinaryOffice.create(name: 'Put a bird on it', boarding_services: true, max_patient_capacity: 5)
    vet = vet_office.veterinarians.create(name: 'Kelsey', on_call: true, review_rating: 9)

    visit "/veterinarians/#{vet.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Review rating')
    expect(find('form')).to have_content('On call')
  end

  context 'given valid data' do
    it 'submits the edit form and updates the veterinarian' do
      vet_office = VeterinaryOffice.create(name: 'Put a bird on it', boarding_services: true, max_patient_capacity: 5)
      vet = Veterinarian.create(name: 'Kelsey', on_call: true, review_rating: 9, veterinary_office_id: vet_office.id)

      visit "/veterinarians/#{vet.id}/edit"

      fill_in 'Name', with: 'Ignacio'
      uncheck 'On call'
      fill_in 'Review rating', with: 10
      click_button 'Save'

      expect(page).to have_current_path("/veterinarians/#{vet.id}")
      expect(page).to have_content('Ignacio')
      expect(page).to_not have_content('Kelsey')
    end
  end

  context 'given invalid data' do
    it 're-renders the edit form' do
      vet_office = VeterinaryOffice.create(name: 'Put a bird on it', boarding_services: true, max_patient_capacity: 5)
      vet = Veterinarian.create(name: 'Kelsey', on_call: true, review_rating: 9, veterinary_office_id: vet_office.id)

      visit "/veterinarians/#{vet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/veterinarians/#{vet.id}/edit")
    end
  end
end
