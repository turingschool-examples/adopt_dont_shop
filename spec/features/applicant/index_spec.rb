require 'rails_helper'

RSpec.describe 'Applicants' do
  describe 'GET /index' do
    it 'is the index page' do
      visit '/applicants'
      expect(page).to have_content('Applicants')
    end
  end
end
