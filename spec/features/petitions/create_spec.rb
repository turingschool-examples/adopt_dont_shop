require 'rails_helper'

RSpec.describe 'application creation' do
  # before(:each) do
  #   @petition = Petition.create!(name: 'Pete', street_address: "249 Tition Dr.", city: "Denver", state: "Colorado", zip_code: 80823)
  # end

  describe 'the application new' do
    it 'renders the new form' do
      visit "/petitions/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
    end
  end

  describe 'the petition create' do
    context 'given valid data' do
      it 'creates the petition and redirects to the petitions show' do
        visit "/petitions/new"

        fill_in 'Name', with: 'Henry'
        fill_in 'Street address', with: '230 Ocean Dr.'
        fill_in 'City', with: 'Austin'
        fill_in 'State', with: 'Texas'
        fill_in 'Zip code', with: 34098
        click_button 'Submit'
        expect(page).to have_current_path(
          "/petitions/#{Petition.last.id}"
        )
        expect(page).to have_content('Henry')
      end
    end
  end
end
