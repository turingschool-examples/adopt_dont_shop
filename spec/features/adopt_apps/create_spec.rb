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

  describe 'the shelter create' do
    context 'given valid data' do
      it 'creates the shelter' do
        visit '/adopt_apps/new'
save_and_open_page

        fill_in 'Name', with: 'Kristen Nestler'
        fill_in 'Street address', with: '111 N. Broadway, E11'
        fill_in 'City', with: 'White Plains'
        fill_in 'State', with: 'NY'
        fill_in 'Zip code', with: '10603'
        click_button "Submit"

        app = AdoptApp.where(name:"Kristen Nestler")
        expect(page).to have_current_path("/adopt_apps/#{app.id}")
        expect(page).to have_content('Kristen Nestler')
      end
    end
  end

  #   context 'given invalid data' do
  #     it 're-renders the new form' do
  #       visit '/shelters/new'
  #       click_button 'Save'

  #       fill_in 'City', with: 'Houston'

  #       expect(page).to have_content("Error: Name can't be blank, Rank can't be blank, Rank is not a number")
  #       expect(page).to have_current_path('/shelters/new')
  #     end
  #   end
  # end
end