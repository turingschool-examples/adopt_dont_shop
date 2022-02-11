require 'rails_helper'

RSpec.describe 'Applicants' do
  describe 'GET /index' do
  end

  describe 'GET /show' do
    it 'displays an applicant' do
      app = Applicant.create!(
        name: 'Jerry',
        address_line_1: '123 First Street',
        city: 'Temecula',
        state: 'CA',
        zipcode: '12345',
        description: 'I want more pets.',
        status: 'In Progress'
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
