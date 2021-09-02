require 'rails_helper'

RSpec.describe 'applications show' do
  describe 'without pets' do
    before :each do
      @app = Application.create!(
        name: 'Tanner',
        address: '12345 Street St',
        city: 'Austin',
        state: 'Texas',
        zipcode: '12345'
      )
       visit application_path(@app.id)
    end

    it 'has the application info' do
      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
      expect(page).to have_content('In Progress')
    end
  end
end
