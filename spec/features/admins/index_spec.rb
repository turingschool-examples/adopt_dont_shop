require 'rails_helper'

RSpec.describe 'admin index page', type: :feature do

  describe 'default page appearance' do
    it 'has content' do
      visit '/admins'

      expect(page).to have_content('Welcome to the Admin Portal')
      expect(page).to have_link('View Animal Shelters')
      expect(page).to have_link('View Applications')
    end
    it 'links to the admin shelters index' do
      visit '/admins'

      click_link 'View Animal Shelters'

      expect(current_path).to eq('/admin/shelters')
    end
    it 'links to the admin applications index' do
      visit '/admins'

      click_link 'View Applications'

      expect(current_path).to eq('/admin/applications')
    end
  end
end