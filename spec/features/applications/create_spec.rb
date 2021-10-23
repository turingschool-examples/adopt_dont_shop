require 'rails_helper'

RSpec.describe "the Application new page" do
  describe 'the application new' do
    it 'renders the new form' do
      visit '/applications/new'

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip code')
      expect(find('form')).to have_content('Description')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application' do
        application_1 = Application.create(name: "Mary Tanaka",
                                        street_address: "123 Kapiolani Blvd.",
                                        city: "Honolulu",
                                        state: "HI",
                                        zip_code: "98684",
                                        description: "I love cats!")

        visit '/pets'

        expect(page).to have_link("Start an Application")
        click_link "Start an Application"

        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("Name")

        fill_in "name", with: "Mary Tanaka"
        fill_in "street_address", with: "123 Kapiolani Blvd."
        fill_in "city", with: "Honolulu"
        fill_in "state", with: "HI"
        fill_in "zip_code", with: "98684"
        fill_in "description", with: "I love cats!"
        click_button "Save"

        expect(page).to have_content("Mary Tanaka")
        expect(page).to have_content("123 Kapiolani Blvd.")
        expect(page).to have_content("98684")
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
        click_button 'Save'

        fill_in 'City', with: 'Denver'

        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Zip code is not a number, Description can't be blank")
        expect(page).to have_current_path('/applications/new')
      end
    end
  end
end
