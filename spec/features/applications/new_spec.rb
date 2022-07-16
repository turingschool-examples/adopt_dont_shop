require 'rails_helper'

RSpec.describe 'Applications#new' do
  describe 'when I submit an application' do
    it 'takes me to /applications/show and I see my info and In progress indicator' do
      visit '/applications/new'
      
      fill_in 'Name', with: 'Sunny Moore'
      fill_in 'Street address', with: '123 Smith St.'
      fill_in 'City', with: 'Portland'
      fill_in 'State', with: 'Oregon'
      fill_in 'Zipcode', with: '97266'
      click_on 'Submit'

      app1 = Application.last
      expect(current_path).to eq("/applications/#{app1.id}")
      expect(page).to have_content('Sunny Moore')
      expect(page).to have_content('123 Smith St.')
      expect(page).to have_content('Portland')
      expect(page).to have_content('Oregon')
      expect(page).to have_content('97266')
      expect(page).to have_content('In Progress')
    end
    it 'takes me back to /applications/new if all fields are not filled, and desplays an error' do
      
    end
  end
end