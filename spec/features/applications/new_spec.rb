require 'rails_helper'

RSpec.describe 'applications creation' do
  before(:each) do
    @application = Application.create!()
  end

  describe 'applications new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
    end
  end

  describe 'applictions create' do
    context 'given valid data' do
      it 'creates the pet and redirects to the shelter pets index' do
        visit "/applications/new"

        fill_in 'Name', with: 'Pabu'
        fill_in 'Street address', with: '123 Ferret St'
        fill_in 'City', with: 'Erie'
        fill_in 'State', with: 'Co'
        fill_in 'Zipcode', with: '80516'
        click_button 'Submit'
        expect(page).to have_current_path("/applications/#{@application.id}")
        expect(page).to have_content('Pabu')
      end
    end
  end
end
