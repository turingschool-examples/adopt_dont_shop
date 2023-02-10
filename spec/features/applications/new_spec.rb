require 'rails_helper'

RSpec.describe 'visit application new page' do
	describe '#create' do
		before do
			visit 'applications/new'
			
			fill_in 'name', with: 'Melissa Comfort'
			fill_in 'street', with: '123 Denver St.'
			fill_in 'city', with: 'Denver'
			fill_in 'state', with: 'CO'
			fill_in 'zip', with: '80214'
			fill_in 'desc', with: 'I have a big home.'
			click_button
	
			@applicant = Application.all.first
		end
		it 'creates a new application when submitting form and I am redirected to show page' do
			expect(page).to have_current_path("/applications/#{@applicant.id}")
		end

		it 'show page contains attributes and status default to in progress' do
			expect(page).to have_content(@applicant.name)
			expect(page).to have_content(@applicant.street)
			expect(page).to have_content(@applicant.city)
			expect(page).to have_content(@applicant.state)
			expect(page).to have_content(@applicant.zip)
			expect(page).to have_content(@applicant.desc)
			expect(page).to have_content(@applicant.status)
		end
  
  describe 'application has to be filled completely' do
    it 'sends an error when form is not complete' do
      visit 'applications/new'

      fill_in 'name', with: 'Melissa Comfort'
      click_button

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Required Information Missing")
    end
  end
	end
end