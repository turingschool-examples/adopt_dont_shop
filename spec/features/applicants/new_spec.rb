require 'rails_helper'

RSpec.describe 'Start new application' do
  describe 'visitor' do
    it 'can access new application' do
      visit '/pets'

      click_on 'Start an Application'

      expect(current_path).to eq('/applicants/new')
    end

    it 'can fill out a new application' do
      visit '/applicants/new'

      fill_in(:name, with: 'Sally')
      fill_in(:street_address, with: '1234 ABC')
      fill_in(:city, with: 'Alphabet')
      select('NY', :from => 'State')
      fill_in(:zip_code, with: 12345)

      click_button('Submit')

      expect(current_path).to eq("/applicants/#{Applicant.all.last.id}")

      expect(page).to have_content('Sally')
      expect(page).to have_content('1234 ABC, Alphabet, NY 12345')
      expect(page).to have_content('In Progress')
    end

    it 'does not create an application when fields left empty' do
      visit '/applicants/new'

      click_on 'Submit'

      expect(page).to have_content('Application not created: Required information missing.')
      expect(current_path).to eq('/applicants/new')

      fill_in(:name, with: 'Sally')
      click_on 'Submit'
      expect(page).to have_content('Application not created: Required information missing.')

      fill_in(:name, with: 'Sally')
      fill_in(:street_address, with: '1234 ABC')
      click_on 'Submit'
      expect(page).to have_content('Application not created: Required information missing.')

      fill_in(:name, with: 'Sally')
      fill_in(:street_address, with: '1234 ABC')
      fill_in(:city, with: 'Alphabet')
      click_on 'Submit'
      expect(page).to have_content('Application not created: Required information missing.')
    end
  end
end
