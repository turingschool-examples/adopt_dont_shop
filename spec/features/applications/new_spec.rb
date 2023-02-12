require 'rails_helper'

describe 'applications new page', type: :feature do
  describe 'user story 3' do
    it 'has returns user to application if any form fields are blank' do
      visit 'applications/new'
      
      click_button 'Save'

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content("Form cannot be blank")
    end  
  end  
end
