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
        expect(page).to have_content("Why I'd make a good home for this pet(s): I love animals")
      end

      it 'I can not create an application without a name' do
        visit '/applications/new'

        fill_in 'Address', with: '123 Main St. Denver, CO 80234'
        fill_in "Why I'd make a good home for this pet(s):", with: 'I love animals'
        click_on 'Submit'

        expect(page).to have_content("Error: Name can't be blank")
        expect(page).to have_button('Submit')
      end
    end
  end
end
