require 'rails_helper'

RSpec.describe Application, type: :feature do
  context "new application form" do  
    it 'intakes all params' do
      visit '/applications/new'
      
      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_content('Description')
    end

    it 'takes us to the new app show once submitted' do
      visit '/applications/new'
      
      fill_in 'Name', with: 'Joann Smith'
      fill_in 'Street address', with: '111 Street Name'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zipcode', with: '00012'
      fill_in 'Description', with: "I'm a great person"
      click_on 'Submit'

      # expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Joann Smith")
      expect(page).to have_content("111 Street Name")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("00012")
      expect(page).to have_content("I'm a great person")
      expect(page).to have_content("In Progress")
    end
  end
end