require 'rails_helper'

RSpec.describe "Create Application" do 
      it 'creates a application form to fill in with name, address, city, state, and zip code' do 
            
            visit '/applications/new'

            expect(find('form')).to have_content('Name')
            expect(find('form')).to have_content('Address')
            expect(find('form')).to have_content('City')
            expect(find('form')).to have_content('State')
            expect(find('form')).to have_content('Zip')
            expect(page).to have_button('Submit')
      end
##i think we might neex to test this using #within blocks
      it 'creates a user application and redirects it to the application show page' do 
            mary = Applicant.create!(name: "Mary", address: "5555 Test Avenue", city: "Denver", state: "CO", zip: 55555)

            fill_in 'Name', with: 'Mary'
            fill_in 'Address', with: '5555 Test Avenue'
            fill_in 'City', with: 'Denver'
            fill_in 'State', with: 'CO'
            fill_in 'Zip', with: 55555

            
            click_on 'Submit'
            expect(current_path).to eq("applications/#{mary.id}")

            expect(page).to have_content('Mary')
            expect(page).to have_content('5555 Test Avenue')
            expect(page).to have_content('Denver')
            expect(page).to have_content('CO')
            expect(page).to have_content(55555)
      end
end
