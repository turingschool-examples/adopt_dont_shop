require 'rails_helper'

RSpec.describe 'adoption application creation' do

  describe 'new adoption applicaiton' do
    it 'renders the new form' do
      visit '/adoption_applications/new'

      fill_in('Name', with: 'Michael Abbott')
      fill_in('Street address', with: '66 Bell St.')
      fill_in('City', with: 'Seattle')
      fill_in('State', with: 'Wa')
      fill_in('Zip code', with: '98121')
      click_button('Submit')

      new_app_id = AdoptionApplication.last.id
      expect(current_path).to eq("/adoption_applications/#{new_app_id}")
    end
  end
end
