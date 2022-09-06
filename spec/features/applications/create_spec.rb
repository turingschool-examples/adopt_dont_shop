require 'rails_helper'

RSpec.describe 'application creation' do
  before :each do
  end

  describe 'content' do
    it 'renders the form' do
      visit '/applications/new'
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Address')
    end
  end

  describe 'application create' do
    context 'given valid data' do
      it 'creates the application' do
        visit '/applications/new'

        fill_in 'Name', with: 'Guy Manfred'
        fill_in 'Address', with: '101 Pearson RD Glendale CA 90102'
        click_button 'Submit'

        expect(page).to have_content('Guy Manfred')
        expect(page).to have_content('In Progress')
      end
    end
  end

end
