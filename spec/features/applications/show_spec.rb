require 'rails_helper'

RSpec.describe 'Application show page' do
  describe 'Applications show page contains' do
    before :each do
      @app = Application.create!(name: 'Oz', street_address: '3504 Gloria Ave.', city: 'Chicago', state: 'IL', zip_code: '80206', description: 'cool dude', status: 'In progress')
    end

    it 'returns Application attributes' do
      visit("/applications/#{@app.id}")

      expect(page).to have_content('Oz')
      expect(page).to have_content('3504 Gloria Ave.')
      expect(page).to have_content('Chicago')
      expect(page).to have_content('IL')
      expect(page).to have_content('80206')
      expect(page).to have_content('cool dude')
      expect(page).to have_content('In progress')
    end
  end
end
