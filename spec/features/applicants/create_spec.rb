require 'rails_helper'

RSpec.describe 'applicant creation' do
  describe 'the applicant new' do
    it 'renders the new form' do
      visit "/applicants/new"

      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip')
    end
  end

  describe 'the applicant create' do
      it 'creates the applicant and redirects to the applicant show page' do
        visit '/applicants/new'

        fill_in 'Name', with: 'Russell Rockwood'
        fill_in 'Address', with: '1065 Walnut St'
        fill_in 'City', with: 'Bremerton'
        fill_in 'State', with: 'WA'
        fill_in 'Zip', with: 98310

        click_button 'Save'
        # expect(page).to have_current_path("/applicants/#{@shelter.id}/pets")
        expect(page).to have_content('Russell Rockwood')
      end

      it 'shows a flash message if empty fields are submitted' do
         visit "/applicants/new"

         click_button 'Save'
         expect(page).to have_current_path("/applicants/new")
         expect(page).to have_content("Application not created: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank, Zip is not a number.")
      end
    end

    # context 'given invalid data' do
    #   it 're-renders the new form' do
    #     visit "/shelters/#{@shelter.id}/pets/new"
    #
    #     click_button 'Save'
    #     expect(page).to have_current_path("/shelters/#{@shelter.id}/pets/new")
    #     expect(page).to have_content("Error: Name can't be blank, Age can't be blank, Age is not a number")
    #   end
end
