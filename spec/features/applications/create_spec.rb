require 'rails_helper'

require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  describe 'Starting an Application' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('Adoption Application')
      expect(find('form')).to have_content('Applicant Name:')
      expect(find('form')).to have_content('Address')
      expect(find('form')).to have_content('Street:')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip Code')
    end
  end

  describe 'the pet create' do
    context 'given valid data' do
      it 'creates the pet and redirects to the shelter pets index' do
        visit "/shelters/#{@shelter.id}/pets/new"

        fill_in 'Name', with: 'Bumblebee'
        fill_in 'Age', with: 1
        fill_in 'Breed', with: 'Welsh Corgi'
        check 'Adoptable'
        click_button 'Save'
        expect(page).to have_current_path("/shelters/#{@shelter.id}/pets")
        expect(page).to have_content('Bumblebee')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/shelters/#{@shelter.id}/pets/new"

        click_button 'Save'
        expect(page).to have_current_path("/shelters/#{@shelter.id}/pets/new")
        expect(page).to have_content("Error: Name can't be blank, Age can't be blank, Age is not a number")
      end
    end
  end
end








RSpec.describe "As a visitor", type: :feature do
  describe "I am directed to New Form" do
    it "I can create a new office" do
      visit '/offices/new'

      fill_in "Name", with: "Office 1"
      fill_in "Capacity", with: "22"
      check "First Aid Available:"

      click_on "Create Office"

      expect(current_path).to eq("/offices")
      expect(page).to have_content("Office 1")
      expect(page).to have_content(22)
      expect(page).to have_content "First Aid Available: true"
    end
  end
end
