require 'rails_helper'

RSpec.describe 'new application page' do
  it 'has a form to fill out an application' do
    visit "/pets"

    click_link "Start an Application"
    expect(current_path). to eq("/applications/new")
    fill_in('Name', with: 'Sam Asghari')
    fill_in('Address', with: '200 Hollywood Blvd')
    fill_in('City', with: 'Los Angeles')
    fill_in('State', with: 'CA')
    fill_in('Zipcode', with: 90027)
    fill_in('Description', with: 'Britney wants a pet')
    click_button('Submit')

    new_application_id = Application.last.id

    expect(current_path).to eq("/applications/#{new_application_id}")
    expect(page).to have_content('Sam Asghari')
    expect(page).to have_content('200 Hollywood Blvd')
    expect(page).to have_content('Los Angeles')
    expect(page).to have_content('In Progress')
  end

  it 'takes one back to the new applications page if a field is not filled in' do
    
  end
end
