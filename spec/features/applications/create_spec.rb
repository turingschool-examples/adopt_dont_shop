require 'rails_helper'

RSpec.describe 'New Application Page' do
  describe 'As a visitor' do
    describe 'the application new' do
      it 'renders the new form' do
        visit "/applications/new"

        expect(page).to have_content('New Application')
        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('Address')
        expect(find('form')).to have_content('City')
        expect(find('form')).to have_content('State')
        expect(find('form')).to have_content('Zip')
      end
    end

    describe 'the application create' do
      describe 'given valid data' do
        it 'redirects to the new applications show page' do
          visit '/applications/new'

          fill_in :name, with: 'George'
          fill_in :address, with: '124 Side Street'
          fill_in :city, with: 'Fairplay'
          fill_in :state, with: 'CO'
          fill_in :zip, with: '80440'
          click_on 'Save'

          expect(current_path).to eq "/applications/#{Application.all.last.id}"
        end
      end

      describe 'given invalid data' do
        it 'redirects to the new applications page' do
          visit '/applications/new'

          click_on 'Save'

          expect(current_path).to eq '/applications'
          expect(page).to have_content("Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank")
          expect(find('form')).to have_content('Name')
          expect(find('form')).to have_content('Address')
          expect(find('form')).to have_content('City')
          expect(find('form')).to have_content('State')
          expect(find('form')).to have_content('Zip')
        end
      end
    end
  end
end
