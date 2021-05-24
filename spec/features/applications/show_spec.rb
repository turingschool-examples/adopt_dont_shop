require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @application_1 = Application.create!(name: 'Matt Wesley', street_address: '456 Orange RD', city: 'Vanilla', state: 'Oregon', zip_code: 97701)
    @application_2 = Application.create!(name: 'Annie Pulzone', street_address: '123 Lava LN', city: 'Sherbert', state: 'Oregon', zip_code: 97703)
  end

  context 'applicant' do
    it 'shows the applicants attributes' do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content("#{@application_1.name}")
      expect(page).to have_content("#{@application_1.street_address}")
      expect(page).to have_content("#{@application_1.city}, #{@application_1.state} #{@application_1.zip_code}")
    end
  end
end
