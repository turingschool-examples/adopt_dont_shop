require 'rails_helper'

RSpec.describe 'Admin shelter ' do
  describe 'show' do
    it 'has a button to approve the application for that specific pet' do
      dfl = Shelter.create!(name: 'Dumb Friends Leauge', rank: 12, city: 'Denver', foster_program: true)
      jerry = Applicant.create!(name: 'Jerry', address_line_1: '123 First Street', city: 'Temecula', state: 'CA',
                                zipcode: '12345', description: 'I want more pets.')
      kirby = jerry.pets.create!(name: 'Kirby', age: 4, breed: 'Maine Coon', adoptable: true, shelter_id: dfl.id)
      pet_app = PetApplication.create!(pet_id: kirby.id, applicant_id: jerry.id)

      visit "/admin/applications/#{jerry.id}"

      within('#pet_sat') do
        expect(pet_app.status).to eq('In Progress')
        click_button("Approve #{kirby.name}")
      end
      expect(current_path).to eq("/admin/applications/#{jerry.id}")
      expect(page).to have_content('Accepted')
    end
  end
end
