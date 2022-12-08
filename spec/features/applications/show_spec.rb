require 'rails_helper' 

RSpec.describe 'application show' do
  describe 'as a visitor' do
    it 'shows application attributes' do
      application = Application.create!(name: 'Joe', address: "123 street lane", description: "I like dogs", pet_names: "kona", status: "pending" )
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)
    end
  end
end