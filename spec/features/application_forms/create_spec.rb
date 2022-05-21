require 'rails_helper'

RSpec.describe ApplicationForm, type: :feature do
  describe "application create page" do
    it "renders the new form" do
      # As a visitor
      # When I visit the pet index page
      # Then I see a link to "Start an Application"
      # When I click this link
      # Then I am taken to the new application page where I see a form
      # When I fill in this form with my:
      #   - Name
      #   - Street Address
      #   - City
      #   - State
      #   - Zip Code
      # And I click submit
      # Then I am taken to the new application's show page
      # And I see my Name, address information, and description of why I would make a good home
      # And I see an indicator that this application is "In Progress"

      shelter_1 = Shelter.create(name: 'Aurora Shelter', city: 'Aurora, CO', foster_program: false, rank: 5)
      shelter_2 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: true, rank: 9)

      pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
      pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter_1.id)
      pet_3 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_2.id)

      visit "/pets/"
      click_link "Start an Application"
      expect(current_path).to eq('/application_forms/new/')

      expect(page).to have_content('New Application')
      fill_in 'Name', with: 'Hank'
      fill_in 'Street address', with: '1234 Some Street'
      fill_in 'City', with: 'Aurora'
      fill_in 'State', with: 'CO'
      fill_in 'Zip code', with: '80015'

      click_button "Submit"

      #where does the post come in on the view?
      expect(current_path).to eq("/application_forms/")
      #not sure about this path

      click_link "View Hank's Application"
      # save_and_open_page

      expect(page).to have_content('Hank')
      expect(page).to have_content('1234 Some Street')
      expect(page).to have_content('Aurora')
      expect(page).to have_content('CO')
      expect(page).to have_content('80015')
      expect(page).to have_content('Description:')
      expect(page).to have_content('Status: In Progress')

    end

    it 're-renders the new form' do
      # Starting an Application, Form not Completed
      #
      # As a visitor
      # When I visit the new application page
      # And I fail to fill in any of the form fields
      # And I click submit
      # Then I am taken back to the new applications page
      # And I see a message that I must fill in those fields.
      visit '/application_forms/new/'

      click_button 'Submit'

      # save_and_open_page

      # fill_in 'City', with: 'Houston'

      # expect(page).to have_content("Error: Name can't be blank, Rank can't be blank, Rank is not a number")
      # expect(page).to have_current_path('/shelters/new')
    end
  end
end
