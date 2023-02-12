require 'rails_helper'

describe 'applications new page', type: :feature do
  describe 'user story 3' do
    it 'has returns user to application if all form fields are blank' do
      visit 'applications/new'
      
      click_button 'Save'

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content("Form cannot be blank")
    end  

    it 'has returns user to application if some form fields are blank' do
      visit 'applications/new'
      
      fill_in "Name", with: "Avery"
      fill_in "Street address", with: "123 January"
      fill_in "City", with: "New York"
      click_button 'Save'

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content("Form cannot be blank")

      visit 'applications/new'
      
      fill_in "Name", with: "Avery"
      click_button 'Save'

      expect(current_path).to eq('/applications/new')
      expect(page).to have_content("Form cannot be blank")
    end  
  end  
end
