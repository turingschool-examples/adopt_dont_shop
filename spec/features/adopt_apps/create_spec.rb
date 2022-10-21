require 'rails_helper'

RSpec.describe 'Application creation' do
  describe 'the application new' do
    it 'renders the new form' do
      visit '/adopt_apps/new'
      expect(page).to have_content('Adoption Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application' do
        visit '/adopt_apps/new'

        fill_in 'Name', with: 'Kristen Nestler'
        fill_in 'Street address', with: '111 N. Broadway, E11'
        fill_in 'City', with: 'White Plains'
        fill_in 'State', with: 'NY'
        fill_in 'Zip code', with: '10603'
        click_button "Submit"

        app = AdoptApp.last 
        expect(page).to have_current_path("/adopt_apps/#{app.id}")
        expect(page).to have_content('Kristen Nestler')
      end
    end
  end

end