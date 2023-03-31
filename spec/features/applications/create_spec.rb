require 'rails_helper'

RSpec.describe 'application creation' do
    before(:each) do
      @application = Application.create(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
    end

    describe 'the application new' do
      it 'renders the new form' do
        visit "/applications/new"

        expect(page).to have_content("New Application")
        expect(find('form')).to have_content("Name:")
        expect(find('form')).to have_content("Street Address:")
        expect(find('form')).to have_content("City:")
        expect(find('form')).to have_content("State:")
        expect(find('form')).to have_content("Zip Code:")
        expect(find('form')).to have_content("Explain why you would make a good home for this pet:")
      end
    end

    describe 'the application create' do
      context 'given valid data' do
        it "creates the new application and redirects to the application's show page" do
          visit "/applications/new"

          fill_in 'Name:', with: 'Bob'
          fill_in 'Street Address:', with: 'Bob'
          fill_in 'City:', with: 'Bob'
          fill_in 'State:', with: 'Bob'
          fill_in 'Zip Code:', with: 'Bob'
          fill_in 'Explain why you would make a good home for this pet:', with: 'I love animals'
          click_button "Submit"
          expect(page).to have_current_path("/applications/#{@application.id}")
          expect(page).to have_content('Bob')
        end
      end

      context 'given invalid data' do
        it 're-renders the new form' do
          visit "/applications/new"

          click_button "Submit"
          expect(page).to have_current_path("/applications/new")
          expect(page).to have_content("Error: All sections must be filled out")
        end
      end
    end
end