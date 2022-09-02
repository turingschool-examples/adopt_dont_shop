require 'rails_helper'

RSpec.describe 'Application creation' do #USER STORY 3

  it 'displays an applicant form that can be submitted' do 

    visit '/applicants/new'

    fill_in 'Name', with: 'Billy Wahl'
    fill_in 'Street address', with: '123 S Street Way'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zip code', with: '80123'
    fill_in 'Description', with: 'I Like Dogs'

    expect(page).to have_button('submit')

    click_button('submit')

    expect(page).to have_content('Billy Wahl')
    expect(page).to have_content('123 S Street Way')
    expect(page).to have_content('Denver')
    expect(page).to have_content('CO')
    expect(page).to have_content('80123')
    expect(page).to have_content('I Like Dogs')
  end

  it 'cant submit incomplete forms' do #STORY 4
    visit '/applicants/new' 

    fill_in 'Name', with: 'Ash Ketchum'
    fill_in 'Street address', with: '123 S Street Way'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    
    fill_in 'Description', with: 'I Like Dogs'

    click_button('submit') 

    expect(current_path).to eq('/applicants/new')
    expect(current_path).to_not eq('/applicants')

    visit '/applicants'

    expect(page).to_not have_content("Ash Ketchum")
  end 


end 