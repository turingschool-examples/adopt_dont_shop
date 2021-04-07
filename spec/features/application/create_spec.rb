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

      expect(page).to have_content('New Application')
      expect(find('form')).to have_content('Full name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('State')
      expect(find('form')).to have_content('Zipcode')
    end
  end

  describe 'the application create' do
    context 'given valid data' do
      it 'creates the application and redirects to that applications show page' do
        visit "/applications/new"

        fill_in 'Full name', with: 'Brock Lesnar'
        fill_in 'Street address', with: '1234 Rock Avenue'
        fill_in 'City', with: 'Queens'
        fill_in 'State', with: 'New York'
        fill_in 'Zipcode', with: 14567
        click_button 'Submit'

        expect(current_path).to have_content("/applications")
        expect(page).to have_content('Brock Lesnar')
      end
    end

    context 'given invalid data' do
      it 're-renders the new form' do
        visit "/applications/new"

        click_button 'Submit'
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Please Fill in All Fields")
      end
    end
  end
end
