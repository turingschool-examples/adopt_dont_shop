require 'rails_helper'

RSpec.describe 'applications show page features' do
  before(:each) do
    @applicant_1 = Application.create!(name: 'Rumiko Takahashi', address: '4307 Saddle Creek Place', city: "Orlando", state: "Florida", zip_code: 32829, status: 0, description: 'Single and has great income, flexible schedule for pet needs.')
  end

  describe 'As a visitor' do
    context 'When I visit an applications show page' do
      it 'shows the applicants attributes' do
        visit "/applications/#{@applicant_1.id}"
        save_and_open_page
        expect(page).to have_content("Name: #{@applicant_1.name}")
        expect(page).to have_content("Address: #{@applicant_1.address}")
        expect(page).to have_content(@applicant_1.city)
        expect(page).to have_content(@applicant_1.state)
        expect(page).to have_content(@applicant_1.zip_code)
        expect(page).to have_content("Status: In_Progress")
        expect(page).to have_content("Description: #{@applicant_1.description}")
      end
    end
  end
end