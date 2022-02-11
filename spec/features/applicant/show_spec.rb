require 'rails_helper'

RSpec.describe 'Applicants' do
  describe 'GET /show' do
    it 'displays an applicant' do
      app = Applicant.create!(
        name: 'Jerry',
        address_line_1: '123 First Street',
        city: 'Temecula',
        state: 'CA',
        zipcode: '12345',
        description: 'I want more pets.'
      )

      visit "/applicants/#{app.id}"

      expect(page).to have_content('Jerry')
      expect(page).to have_content('123 First Street')
      expect(page).to have_content('Temecula')
      expect(page).to have_content('CA')
      expect(page).to have_content('12345')
      expect(page).to have_content('I want more pets.')
      expect(page).to have_content('In Progress')
    end

    it 'shows the pets the applicant applied for' do
      dfl = Shelter.create!(name: 'Dumb Friends Leauge', rank: 12, city: 'Denver', foster_program: true)
      jerry = Applicant.create!(name: 'Jerry', address_line_1: '123 First Street', city: 'Temecula', state: 'CA',
                                zipcode: '12345', description: 'I want more pets.')
      kirby = jerry.pets.create!(name: 'Kirby', age: 4, breed: 'Maine Coon', adoptable: true, shelter_id: dfl.id)
      pig = Pet.create!(name: 'Pig', age: 7, breed: 'Lab', adoptable: true, shelter_id: dfl.id)

      visit "/applicants/#{jerry.id}"

      expect(page).to have_link(kirby.name)
      expect(page).to_not have_content(pig.name)
    end
  end
end
