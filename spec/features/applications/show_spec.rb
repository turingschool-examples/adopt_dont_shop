require 'rails_helper' 

RSpec.describe 'application show' do
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" ) }
  let!(:application_2) { Application.create!(name: 'Bob', street_address: "789 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: nil, status: "in progress" ) }
  describe 'as a visitor' do
    it 'shows application attributes' do
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)

    end

    it 'allows a pet to be selected and added to application as an ApplicationPet' do
      visit "/applications/#{application.id}"

      
      
    end
  end
end