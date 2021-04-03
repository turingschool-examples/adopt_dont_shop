require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    applicant = Application.create!(name: "Fred",
                              street_address: "123 way",
                              city: "Denver",
                              state: "Colorado",
                              zip_code: 80204,
                              description: "I like dogs",
                              status: "In Progress",
                              created_at: Time.now,
                              updated_at: Time.now
                              )
  end

  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
      # expect(find('form')).to have_content('Description')
      # expect(find('form')).to have_content('Status')
    end
  end
end
