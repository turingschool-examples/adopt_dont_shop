# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'veterinarian creation' do
  before(:each) do
    @vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
  end

  describe 'the veterinarian new' do
    it 'renders the new form' do
      visit "/veterinary_offices/#{@vet_office.id}/veterinarians/new"

      expect(page).to have_content('New Veterinarian')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Review rating')
      expect(find('form')).to have_content('On call')
    end
  end

  describe 'the veterinarian create' do
    context 'given valid data' do
      it 'creates the vet and redirects to the veterinary offices vet index' do
        visit "/veterinary_offices/#{@vet_office.id}/veterinarians/new"

        fill_in 'Name', with: 'Dr. Burstyn'
        fill_in 'Review rating', with: 10
        check 'On call'
        click_button 'Save'
        expect(page).to have_current_path(
          "/veterinary_offices/#{@vet_office.id}/veterinarians"
        )
        expect(page).to have_content('Dr. Burstyn')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/veterinary_offices/#{@vet_office.id}/veterinarians/new"

        click_button 'Save'
        expect(page).to have_current_path(
          "/veterinary_offices/#{@vet_office.id}/veterinarians/new"
        )
        expect(page).to have_content("Error: Name can't be blank, Review rating can't be blank, Review rating is not a number")
      end
    end
  end
end
