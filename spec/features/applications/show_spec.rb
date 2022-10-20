require 'rails_helper'

RSpec.describe "application show page", type: :feature do
  describe '/applications/:id' do
    before(:each) do
      @app = Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")
    end

    it 'shows a unique application and its attributes' do
      visit "/applications/#{@app.id}"

      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.street_address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
      expect(page).to have_content(@app.description)
      expect(page).to have_content(@app.status)
    end
  end
end