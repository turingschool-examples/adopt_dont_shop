require 'rails_helper'

RSpec.describe 'Applicants' do
  describe 'GET /index' do
    it 'displays a link to an application form' do
      visit '/applicants'
      expect(page).to have_link('Start Application')
      click_link('Start Application')
      expect(page).to have_current_path('/applicants/new')
    end

    it 'the submit link takes me to that applicants page' do
      app = Applicant.create!(
        name: 'Jerry',
        address_line_1: '123 First Street',
        city: 'Temecula',
        state: 'CA',
        zipcode: '12345',
        description: 'I want more pets.'
      )
      visit '/applicants'
      expect(page).to have_link('Start Application')
      click_link('Start Application')

      expect(page).to have_current_path('/applicants/new')

      fill_in 'applicant_name', with: 'Jerry'
      fill_in 'applicant_address_line_1', with: '123 First Street'
      fill_in 'applicant_city', with: 'Temecula'
      fill_in 'applicant_state', with: 'CA'
      fill_in 'applicant_zipcode', with: '12345'

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
  end
end
