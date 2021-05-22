# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shelter creation' do
  describe 'the shelter new' do
    it 'renders the new form' do
      visit '/shelters/new'

      expect(page).to have_content('New Shelter')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('Rank')
      expect(find('form')).to have_content('Foster program')
    end
  end

  describe 'the shelter create' do
    context 'given valid data' do
      it 'creates the shelter' do
        visit '/shelters/new'

        fill_in 'Name', with: 'Houston Shelter'
        fill_in 'City', with: 'Houston'
        check 'Foster program'
        fill_in 'Rank', with: 7
        click_button 'Save'

        expect(page).to have_current_path('/shelters')
        expect(page).to have_content('Houston Shelter')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/shelters/new'
        click_button 'Save'

        fill_in 'City', with: 'Houston'

        expect(page).to have_content("Error: Name can't be blank, Rank can't be blank, Rank is not a number")
        expect(page).to have_current_path('/shelters/new')
      end
    end
  end
end
