require 'rails_helper'

RSpec.describe 'Applicants' do
  describe 'Subit link to show page' do
    it 'the submit link takes me to that applicants page' do
      app = Applicant.create!(
        name: 'Jerry',
        address_line_1: '123 First Street',
        city: 'Temecula',
        state: 'CA',
        zipcode: '12345',
        description: 'I want more pets.'
      )
      visit '/pets'
      expect(page).to have_link('Start Application')
      click_link('Start Application')

      expect(page).to have_current_path('/applicants/new')

      fill_in 'applicant_name', with: 'Jerry'
      fill_in 'applicant_address_line_1', with: '123 First Street'
      fill_in 'applicant_city', with: 'Temecula'
      fill_in 'applicant_state', with: 'CA'
      fill_in 'applicant_zipcode', with: '12345'
      fill_in 'applicant_description', with: 'I want more pets'

      click_on 'Submit'

      expect(page).to have_content('Jerry')
      expect(page).to have_content('In Progress')
    end
  end
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
