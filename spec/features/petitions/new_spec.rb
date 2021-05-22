# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'petitions creation' do
  describe 'petitions new' do
    it 'renders the form for new petitions' do
      visit '/petitions/new'

      expect(page).to have_content('Apply to Adopt a Pet!')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(page).to have_button('Start Application')
    end

    it 'creates a new application when button is clicked' do
      visit '/petitions/new'
      fill_in 'Name', with: 'Ted Leo'
      fill_in 'Street Address', with: '123 Pharmacist Ln'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zipcode', with: '80210'
      result = click_button 'Start Application'
      id = Petition.last.id

      expect(current_path).to eq "/petitions/#{id}"
    end
  end
end
