require 'rails_helper'

RSpec.describe 'Applications show page' do
  describe 'when I visit /applcations/:id' do
    it 'shows all of the application information' do
      application = Application.create!(app_name: 'Billy Bob', address: "54984 Bulldog Rd Salem, OR 97301", description: "Billy Bob wants a buddy", pet_names: "Bobby", status: "Pending")
      visit "/applications/#{application.id}"
save_and_open_page
      expect(page).to have_content(application.app_name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)
    end
  end
end