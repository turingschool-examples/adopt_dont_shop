require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'The new application page' do
    it "renders the new form" do
      visit '/applicants/new'

      expect(page).to have_content("New Application")
      expect(find('form')).to have_content('First Name')
      expect(find('form')).to have_content('Last Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_content('Description')
      expect(page).to have_button("Create Application")
    end
  end


  context 'given valid data' do
    it 'creates the application' do
      visit '/applicants/new'

      fill_in 'First Name', with: 'Linda'
      fill_in 'Last Name', with: 'Smith'
      fill_in 'Street Address', with: '737 Royal Lane'
      fill_in 'City', with: 'Columbus'
      select 'OH', :from => 'state'
      fill_in 'Zipcode', with: '39053'
      fill_in 'Description', with: 'I would make a great pet owner'
      fill_in 'Status', with: 'In Progress'
      click_button 'Create Application'


      # Then I am taken to the new application's show page
      expect(page).to have_content('Linda')
      expect(page).to have_content('Smith')
      expect(page).to have_content('737 Royal Lane')
      expect(page).to have_content('Columbus')
      expect(page).to have_content('OH')
      expect(page).to have_content('I would make a great pet owner')
      expect(page).to have_content('In Progress')

      expect(page).not_to have_content('Sherry')
    end
  end

  context 'If I submit without filling in any of the form fields' do
    it "Then I am taken back to the new applications page" do
      visit '/applicants/new'

      fill_in 'First Name', with: 'Linda'
      fill_in 'Last Name', with: 'Smith'
      # street address left out
      #city left out
      select 'OH', :from => 'state'
      #zipcode was purposely not filled
      fill_in 'Description', with: 'I would make a great pet owner'
      fill_in 'Status', with: 'In Progress'
      click_button 'Create Application'

      expect(current_path).to eq('/applicants/new')

      expect(page).to have_content("Please Enter Data For Each Field")
    end
  end
end
