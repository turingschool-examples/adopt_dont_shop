require 'rails_helper'

RSpec.describe 'applicaton creation' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Save The Animals', city: 'Denver', rank: 4, foster_program: true)
    @pet1 = Pet.create!(name: 'Joey', age: 2, breed: 'Poodle', adoptable: true, shelter_id: @shelter.id)
    @application = Application.create!(name: 'Andrew',
      street_address: '112 Greenbrook',
      city: 'Denver',
      state: 'CO',
      zipcode: '80207',
      description: 'Happy, friendly, cool',
      status: 'In Progress',
      pets: Pet.all
    )

  end

  describe 'the veterinarian new' do
    it 'renders the new form for applicaiton' do
      visit "/applications/new"

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
      expect(find('form')).to have_content('Description')
    end

    it 'takes me to applicaton show page and displays information' do
      visit "/applications/new"
      fill_in 'Name', with: @application.name
      fill_in 'Street address', with: @application.street_address
      fill_in 'City', with: @application.city
      fill_in 'State', with: @application.state
      fill_in 'Zipcode', with: @application.zipcode
      fill_in 'Description', with: @application.description
      click_button "Submit"
      expect(current_path).to_not eq("/applications/#{@application.id}")
    end
  end

  describe 'error for application creation' do
    context 'given valid data' do
      it 'creates applciation and gives error when not filled in correctly' do
        visit "/applications/new"

        fill_in('Name', with: 'Tyler')
        fill_in('City', with: 'Las Vegas')
        fill_in('State', with: 'NV')
        fill_in('Zipcode', with: '99977')

        click_button "Submit"
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error")
      end
    end
  end
end
