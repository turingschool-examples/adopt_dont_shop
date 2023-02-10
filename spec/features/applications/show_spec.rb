require 'rails_helper'

RSpec.describe 'applications show page features' do
  before(:each) do
    @applicant_1 = Application.create!(name: 'Rumiko Takahashi', address: '4307 Saddle Creek Place, Orlando, Fl, 32829', status: 'In Progress', description: 'Single and has great income, flexible schedule for pet needs.',)
  end

  describe 'As a visitor' do
    context 'When I visit an applications show page' do
      it 'shows the applicants attributes' do
        visit "/applications/#{@applicant_1.id}"
        
        expect(page).to have_content("Name: #{@applicant_1.name}")
        expect(page).to have_content("Address: #{@applicant_1.address}")
        expect(page).to have_content("Status: #{@applicant_1.status}")
        expect(page).to have_content("Description: #{@applicant_1.description}")
      end
    end
  end
end