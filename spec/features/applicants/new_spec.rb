require 'rails_helper' 

RSpec.describe 'New Applicant Form' do 
 it 'Displays form to fill out for new applicant to be submitted, when filled, routed back to applicant index page' do 
    visit '/applicants/new'

    fill_in 'Name', with: 'Kevin Ta'
    fill_in 'Street address', with: '999 Dead End Drive'
    fill_in 'City', with: 'Aurora'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '80011'
    fill_in 'Description', with: 'Looking for a friend'

    click_button("Submit")
    
    expect(page).to have_content('Kevin Ta')
    expect(page).to_not have_content("Ashley Turner")
 end 

  it 'When I am filling out a new applicant form and fail to fill in a field, I see an error message telling me to fill missing field' do 

    visit '/applicants/new'

    fill_in 'Street address', with: '999 Dead End Drive'
    fill_in 'City', with: 'Aurora'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '80011'
    fill_in 'Description', with: 'Looking for a friend'

    click_button("Submit")
    expect(current_path).to eq("/applicants/new")
    expect(current_path).to_not eq("/applicants")
    expect(page).to have_content("Error: Name can't be blank")
  end

end