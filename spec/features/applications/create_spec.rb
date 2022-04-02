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
      click_button "Submit"
      expect(current_path).to eq("/applications")
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates applciation with filled in data' do
        visit "/applications/new"

        fill_in 'Name', with: 'Tyler'
        fill_in 'Street address', with: '123 Cherry Lane'
        fill_in 'City', with: 'Las Vegas'
        fill_in 'State', with: 'NV'
        fill_in 'Zipcode', with: '99977'
        fill_in 'Description', with: 'I love dogs'

        click_button "Submit"
        expect(page).to have_current_path(
              "/applications"
            )
        # expect(page).to have_content('Tyler')
        # expect(page).to have_content('Dr. Burstyn')
        # expect(page).to have_content('Dr. Burstyn')
        # expect(page).to have_content('Dr. Burstyn')
      end
    end
    #
    # context 'given invalid data' do
    #   it 're-renders the new form' do
    #     visit "/veterinary_offices/#{@vet_office.id}/veterinarians/new"
    #
    #     click_button 'Save'
    #     expect(page).to have_current_path(
    #       "/veterinary_offices/#{@vet_office.id}/veterinarians/new"
    #     )
    #     expect(page).to have_content("Error: Name can't be blank, Review rating can't be blank, Review rating is not a number")
    #   end
    # end
  end
end
