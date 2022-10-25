require 'rails_helper'

RSpec.describe 'Shelter Edit' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end
  describe 'When I visit /shelters/:id/edit' do
    describe 'Then I see' do
      it "the shelter edit form" do
        visit "/shelters/#{@shelter.id}/edit"

        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('City')
        expect(find('form')).to have_content('Rank')
        expect(find('form')).to have_content('Foster program')
      end

      context "given valid data" do
        it "the edit form and updates the shelter" do
          visit "/shelters/#{@shelter.id}/edit"

          fill_in 'Name', with: 'Wichita Shelter'
          fill_in 'City', with: 'Wichita'
          uncheck 'Foster program'
          fill_in 'Rank', with: 10
          click_button 'Save'

          expect(page).to have_current_path('/shelters')
          expect(page).to have_content('Wichita Shelter')
          expect(page).to_not have_content('Houston Shelter')
        end
      end

      context "given invalid data" do
        it 're-renders the edit form' do
          visit "/shelters/#{@shelter.id}/edit"

          fill_in 'Name', with: ''
          fill_in 'City', with: 'Wichita'
          uncheck 'Foster program'
          click_button 'Save'

          expect(page).to have_content("Error: Name can't be blank")
          expect(page).to have_current_path("/shelters/#{@shelter.id}/edit")
        end
      end
    end
  end
end
