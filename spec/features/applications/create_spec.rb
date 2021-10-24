require 'rails_helper'

RSpec.describe 'application creation' do
  # before(:each) do
  #   @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #   @sammy = Pet.create!(adoptable: true, age: 1, breed: 'diluted calico', name: 'Sammy', shelter_id: @shelter.id)
  #   @smokie = Pet.create!(adoptable: true, age: 3, breed: 'tuxido', name: 'Smokie', shelter_id: @shelter.id)
  #   @application = Application.create!(name: 'Haewon Jeon',
  #                                     full_address: '305 Havard Dr., Fort Collins, CO 80212',
  #                                     description: "Because we are awesome",
  #                                     app_status: "pending")
  #   @application.pets << @sammy
  #   @application.pets << @smokie
  # end

  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street Address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zip Code')

    end
  end

  describe 'the application create' do
    it 'creates the application and redirects to the shelter applications index' do
      visit "/applications/new"

      fill_in 'Name', with: 'Sean Morris'
      fill_in 'Street Address', with: '4950 Hooker St.'
      fill_in 'City', with: 'Denver'
      fill_in 'State', with: 'CO'
      fill_in 'Zip Code', with: '80201'

      click_button 'Submit Application'
      # expect(page).to have_current_path("/applications/#{@application.id}")
      expect(page).to have_content('Sean Morris')
      expect(page).to have_content('4950 Hooker St., Denver, CO 80201')
      expect(page).to have_content('In Progress')
    end
  end
end
