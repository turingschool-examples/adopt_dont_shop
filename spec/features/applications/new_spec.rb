require 'rails_helper'

RSpec.describe 'application creation' do
  before :each do
    @application1 = Application.create!(name: 'Murph', street: '123 Apple St', city: 'Boca Raton', state: 'FL', zip: 33498, description: 'I want Jack', status: 'in progress')
    @application2 = Application.create!(name: 'Derek', street: '456 Orange Ave', city: 'Fort Collins', state: 'CO', zip: 80521, description: 'I have lots of frisbees', status: 'in progress')

    visit "/applications/new"

    it 'displays a submitable form' do
      fill_in :name, with: "Murph"
      fill_in :street, with: "123 Apple St"
      fill_in :city, with: "Boca Raton"
      fill_in :state, with: "FL"
      fill_in :zip, with: 33498

      click_button "submit"
      
      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content("Boca")
    end
  end
end