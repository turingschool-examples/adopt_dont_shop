require 'rails_helper'

RSpec.describe 'application creation' do
  describe 'the application new' do
    it "renders the new form" do
      visit '/applicants/new'

      expect(page).to have_content("New Application")
      expect(find('form')).to have_content('First name')
      expect(find('form')).to have_content('Last name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
      expect(page).to have_button("Create Application")
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application' do
        visit '/applicants/new'

        fill_in 'First Name ', with: 'Linda'
        fill_in 'Last Name', with: 'Smith'
        fill_in 'Street Adddress', with: '737 Royal lane'
        fill_in 'City', with: 'Columbus'
        fill_in 'State', with: 'Ohio' #this could be drop down select 50 states
        fill_in 'Zip Code', with: '39053'
        click_button 'Sumbit Application'


        # Then I am taken to the new application's show page
        expect(page).to have_content('Linda')
        expect(page).to have_content('Smith')
        expect(page).to have_content('737 Royal Lane')
        expect(page).to have_content('Columbus')
        expect(page).to have_content('Ohio')

        expect(page).not_to have_content('Sherry')
      end
    end
  end
end
    # As a visitor
    # XX When I visit the pet index page
    # XX Then I see a link to "Start an Application"
    # XX When I click this link
    # XX Then I am taken to the new application page where I see a form
    # XX When I fill in this form with my:
    #
    # Name
    # Street Address
    # City
    # State
    # Zip Code
    # And I click submit
    # ***Then I am taken to the new application's show page
    # And I see my Name, address information, and description of why I would make a good home
    # And I see an indicator that this application is "In Progress"
