require 'rails_helper'

RSpec.describe 'Admin shelter ' do
  describe 'index ' do
    it 'displays shelters in the system in a revered alphabetial order' do
      dfl = Shelter.create!(name: 'Dumb Friends Leauge', rank: 12, city: 'Denver', foster_program: true)
      aspca = Shelter.create!(name: 'ASPCA SHELTER', rank: 5, city: 'Thorton', foster_program: true)
      jerry = Applicant.create!(name: 'Jerry', address_line_1: '123 First Street', city: 'Temecula', state: 'CA',
                                zipcode: '12345', description: 'I want more pets.')
      kirby = Pet.create!(name: 'Kirby', age: 4, breed: 'Maine Coon', adoptable: true, shelter_id: dfl.id)
      pig = Pet.create!(name: 'Pig', age: 7, breed: 'Lab', adoptable: true, shelter_id: dfl.id)

      visit '/admin/shelters/'

      expect(page).to have_content(dfl.name)
      expect(page).to have_content(aspca.name)
      expect(dfl.name).to appear_before(aspca.name)
    end
  end
end
