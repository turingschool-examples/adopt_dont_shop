# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the vet office update' do
  it 'shows the vet office edit form' do
    vet_office = VeterinaryOffice.create(name: 'Aurora vet office', boarding_services: false, max_patient_capacity: 9)

    visit "/veterinary_offices/#{vet_office.id}/edit"

    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Max patient capacity')
    expect(find('form')).to have_content('Boarding services')
  end

  context 'given valid data' do
    it 'submits the edit form and updates the vet office' do
      vet_office = VeterinaryOffice.create(name: 'Aurora vet office', boarding_services: false, max_patient_capacity: 9)

      visit "/veterinary_offices/#{vet_office.id}/edit"

      fill_in 'Name', with: 'Wichita vet office'
      uncheck 'Boarding services'
      fill_in 'Max patient capacity', with: 10
      click_button 'Save'

      expect(page).to have_current_path('/veterinary_offices')
      expect(page).to have_content('Wichita vet office')
      expect(page).to_not have_content('Houston vet office')
    end
  end

  context 'given invalid data' do
    it 're-renders the edit form' do
      vet_office = VeterinaryOffice.create(name: 'Aurora vet office', boarding_services: false, max_patient_capacity: 9)

      visit "/veterinary_offices/#{vet_office.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/veterinary_offices/#{vet_office.id}/edit")
    end
  end
end
