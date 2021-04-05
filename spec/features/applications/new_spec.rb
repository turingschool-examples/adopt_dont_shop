require 'rails_helper'

RSpec.describe 'New Application' do
  describe 'As a visitor' do
    describe 'When I visit the new application form by clicking a link on the pets index' do
      it 'I can create a new application' do
        visit '/pets'

        click_link 'Start an Application'

        expect(current_path).to eq('/applications/new')

        fill_in 'Name', with: 'Gaelyn Cooper'
        fill_in 'Address', with: '123 Main St. Denver, CO 80234'
        fill_in "Why I'd make a good home for this pet(s):", with: 'I love animals'
        click_on 'Submit'

        expect(current_path).to eq("/applications/#{Application.first.id}")
        expect(page).to have_content('Gaelyn Cooper')
        expect(page).to have_content('Address: 123 Main St. Denver, CO 80234')
        expect(page).to have_content('Description: I love animals')
      end
    end
  end
end
