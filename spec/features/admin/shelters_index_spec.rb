require 'rails_helper'

RSpec.describe 'Admin shelter ' do
  describe 'index ' do
    it 'displays shelters in the system in a revered alphabetial order' do
      dfl = Shelter.create!(name: 'Dumb Friends Leauge', rank: 12, city: 'Denver', foster_program: true)
      aspca = Shelter.create!(name: 'ASPCA SHELTER', rank: 5, city: 'Thorton', foster_program: true)

      visit '/admin/shelters/'

      expect(page).to have_content(dfl.name)
      expect(page).to have_content(aspca.name)
      expect(dfl.name).to appear_before(aspca.name)
    end

    it 'displays all shelters with pending applications' do
      dfl = Shelter.create!(name: 'Dumb Friends Leauge', rank: 12, city: 'Denver', foster_program: true)
      jerry = Applicant.create!(name: 'Jerry', address_line_1: '123 First Street', city: 'Temecula', state: 'CA',
                                zipcode: '12345', description: 'I want more pets.', status: 'Pending')
      visit '/admin/shelters/'
      expect(page).to have_content('Shelters With Pending Applications')
      expect(page).to have_content(dfl.name)
    end
  end
end
