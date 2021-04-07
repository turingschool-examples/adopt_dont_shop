require 'rails_helper'

RSpec.describe 'application creation' do
  before(:each) do
    @user_1 = User.create!(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.', city: 'Cleveland', state: 'OH', zipcode: 18907)
    @user_2 = User.create!(full_name: 'Yo Lo', street_address: '95837 Tomahawk Dr.', city: 'Cincinatti', state: 'OH', zipcode: 44567)
    @user_3 = User.create!(full_name: 'Sam Smith', street_address: '34573 Board Rd.', city: 'Austin', state: 'TX', zipcode: 67875 )

    @application_1 = @user_1.applications.create!(status: 'yessir', description: 'give me the damn dog', user_id: @user_1.id)
    @application_2 = @user_2.applications.create!(status: 'yessir', description: 'give me the damn dog', user_id: @user_2.id)
    @application_3 = @user_3.applications.create!(status: 'yessir', description: 'give me the damn dog', user_id: @user_3.id)
  end

  describe 'the application new' do
    it 'renders the new form' do
      visit "/applications/new"

      # expect(page).to have_content('New Application')
      # expect(find('form')).to have_content('Full Name')
      # expect(find('form')).to have_content('Street Address')
      # expect(find('form')).to have_content('City')
      # expect(find('form')).to have_content('State')
      # expect(find('form')).to have_content('Zipcode')
      # expect(find('form')).to have_content('Description')
    end
  end

  # describe 'the pet create' do
  #   context 'given valid data' do
  #     it 'creates the pet and redirects to the shelter pets index' do
  #       visit "/shelters/#{@shelter.id}/pets/new"
  #
  #       fill_in 'Name', with: 'Bumblebee'
  #       fill_in 'Age', with: 1
  #       fill_in 'Breed', with: 'Welsh Corgi'
  #       check 'Adoptable'
  #       click_button 'Save'
  #       expect(page).to have_current_path("/shelters/#{@shelter.id}/pets")
  #       expect(page).to have_content('Bumblebee')
  #     end
  #   end
  #
  #   context 'given invalid data' do
  #     it 're-renders the new form' do
  #       visit "/shelters/#{@shelter.id}/pets/new"
  #
  #       click_button 'Save'
  #       expect(page).to have_current_path("/shelters/#{@shelter.id}/pets/new")
  #       expect(page).to have_content("Error: Name can't be blank, Age can't be blank, Age is not a number")
  #     end
  #   end
  # end
end
