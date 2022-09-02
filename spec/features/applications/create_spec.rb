require 'rails_helper'

RSpec.describe 'the application creation' do

  describe 'the pet new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
    end
  end

    describe 'the application create' do
      context 'given valid data' do
        it 'creates the application and redirects to the application show page' do
          visit "/applications/new"

          fill_in 'Name', with: "Carter Ball"
          fill_in 'Address', with: "123 Easy Street"
          fill_in 'City', with: "Atlanta"
          fill_in 'State', with: "GA"
          fill_in 'Zipcode', with: 30307
  
          click_on "Submit"

          app = Application.last
          
          expect(page).to have_current_path("/applications/#{app.id}")
          expect(page).to have_content('Carter Ball')
        end
      end
  
    #   context 'given invalid data' do
    #     it 're-renders the new form' do
    #       visit "/shelters/#{@shelter.id}/pets/new"
  
    #       click_button 'Save'
    #       expect(page).to have_current_path("/shelters/#{@shelter.id}/pets/new")
    #       expect(page).to have_content("Error: Name can't be blank, Age can't be blank, Age is not a number")
    #     end
    #   end
    # end
  end



end

