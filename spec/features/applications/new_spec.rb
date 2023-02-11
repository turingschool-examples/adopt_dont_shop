require 'rails_helper' 
RSpec.describe 'Starting a new application' do
 
  it 'allows an applicant to fill out an application' do
    visit '/applications/new'

    fill_in 'Name:', with: 'Amy Nelson'
    fill_in 'Street Address:', with: '123 Rainbow rd'
    fill_in 'City:', with: 'Golden'
    fill_in 'State:', with: 'Colorado'
    fill_in 'Zip Code:', with: 80401
    fill_in 'Application Justification', with: "Pets love me!"

    click_on 'Submit Application'

    expect(current_path).to eq("/applications/#{Application.last.id}")
  end

  it 'does not accept incomplete applications' do 
    visit '/applications/new'

    fill_in 'Name:', with: 'Amy Nelson'
    fill_in 'Street Address:', with: '123 Rainbow rd'
    fill_in 'City:', with: 'Golden'
    fill_in 'State:', with: 'Colorado'

    click_on 'Submit Application'

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Description can't be blank")
  end
end