require 'rails_helper'

RSpec.describe 'Application Show Page' do
  describe 'when visiting the page' do
    before :each do
      @app_1 = Application.create!(
        name: 'Anita Barker',
        street_address: '2468 Park Blvd.',
        city: 'Denver',
        state: 'CO',
        zip: '80202'
      )

      visit "/application/#{@app_1.id}"
    end
  end
end
