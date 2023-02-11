require 'rails_helper'

RSpec.describe 'Application New Page' do
  describe 'when I click on link' do
    it "Then I am taken to the new application page where I see a form" do
      visit "/pets"

      click_on "Start an Application"

      expect(current_path).to eq("/applications/new")
    end

    it 'I fill in this form with info' do
      
      visit "/applications/new"
      
      fill_in 'Name', with: 'Meredith'
      fill_in 'street_address', with: '20 E. Bayaud Ave.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'Colorado'
      fill_in 'zip_code', with: '80209'
      fill_in 'Description', with: 'I love dogs with all my heart and soul'
      
      click_on "Submit"

      expect(current_path).to eq("/applications/#{Application.last.id}")
      expect(page).to have_content('Meredith')
      expect(page).to have_content('20 E. Bayaud Ave.')
      expect(page).to have_content('Denver')
      expect(page).to have_content('Colorado')
      expect(page).to have_content(80209)
      expect(page).to have_content('I love dogs with all my heart and soul')
    end

    it 'I fail to fill in form fields, submit, and am taken back to new applications page' do
      
      visit "/applications/new"
      
      click_on "Submit"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Street address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip code can't be blank")
      expect(page).to have_content("Description can't be blank")

    end

    describe 'zip code format validation' do
      it 'required zip_code to be ##### or #####-####' do
        visit "/applications/new"
      
        fill_in 'Name', with: 'Meredith'
        fill_in 'street_address', with: '20 E. Bayaud Ave.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'Colorado'
        fill_in 'zip_code', with: '8009'
        fill_in 'Description', with: 'I love dogs with all my heart and soul'
        click_on "Submit"

        expect(page).to have_content("Zip code should be 12345 or 12345-1234")

        visit "/applications/new"

        fill_in 'Name', with: 'Meredith'
        fill_in 'street_address', with: '20 E. Bayaud Ave.'
        fill_in 'City', with: 'Denver'
        fill_in 'State', with: 'Colorado'
        fill_in 'zip_code', with: 'abcde'
        fill_in 'Description', with: 'I love dogs with all my heart and soul'

        click_on "Submit"
        expect(page).to have_content("Zip code should be 12345 or 12345-1234")
      end
    end
  end
end