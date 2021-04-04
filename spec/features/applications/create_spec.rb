require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'Starting an Application' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('Adoption Application')
      expect(find('form')).to have_content('Applicant name')
      expect(find('form')).to have_content('Street')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'Create the application' do
    context 'given valid data' do
      it 'creates the application' do
        visit "/applications/new"

        fill_in 'Applicant name', with: 'Some person'
        fill_in 'Street', with: "321 Court"
        fill_in 'City', with: 'Longmont'
        select 'CO', :from => 'State'
        fill_in 'Zip code', with: 80000
        click_button 'Submit'

        # expect(current_path).to eq("/applications/#{application.id}") <-- how to target new id?
        expect(page).to have_content("Some person")
        expect(page).to have_content("321 Court")
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        fill_in 'Applicant name', with: 'Vincent Adultman'
        select 'CA', :from => 'State'
        fill_in 'Zip code', with: 90200

        click_button 'Submit'

        expect(page).to have_content("Error: Street can't be blank, City can't be blank")
        expect(page).to have_current_path('/applications/new')
      end
    end
  end
end
