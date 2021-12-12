require 'rails_helper'

RSpec.describe 'application creation' do

  it "creates new application" do
    visit '/applications/new'
    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip')
    expect(find('form')).to have_content('Description')
    expect(page).to have_button('Save')

  end

  it 'creates the application and redirects to the applications show page' do

    visit '/applications/new'
    fill_in 'Name', with: 'Levon'
    fill_in 'Address', with: '69 Woodstock St'
    fill_in 'City', with: 'Woodstock'
    fill_in 'State', with: 'New York'
    fill_in 'Zip', with: '69420'
    fill_in 'Description', with: "this is a description"
    click_button 'Save'
    application = Application.find_by(name:'Levon')
    expect(page).to have_current_path("/applications/#{application.id}")
    expect(page).to have_content('Levon')
    expect(page).to have_content('69 Woodstock St')
    expect(page).to have_content('Woodstock')
    expect(page).to have_content('New York')
    expect(page).to have_content('69420')
    expect(page).to have_content("this is a description")
  end

  context 'given invalid data' do
      it 're-renders the new form' do
        visit '/applications/new'
        fill_in "Name", with: "tester"
        click_button 'Save'
        expect(page).to have_current_path('/applications/new')
        expect(page).to have_content("Error: Name can't be blank, Address can't be blank, City can't be blank, State can't be blank, Zip can't be blank, Description can't be blank")
      end
    end
end
