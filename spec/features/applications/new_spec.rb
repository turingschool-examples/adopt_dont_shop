require 'rails_helper'

RSpec.describe 'Application #new view' do 
    it 'has a form that allows the user to create a new application' do 
        visit '/applications/new'
        fill_in 'name', with: 'Ron'
        fill_in 'street_address', with: '19 Dart'
        fill_in 'city', with: 'Redlands'
        fill_in 'state', with: 'CA'
        fill_in 'zipcode', with: '93003'
        fill_in 'description', with: "I've fallen in love with this dog"
        click_button 'Submit'
    end 

    it 'will notify the user if they do not completely fill out all fields of application.' do 
        visit 'applications/new'
        fill_in 'name', with: 'Ron'
        fill_in 'street_address', with: '19 Dart'
        click_button 'Submit'
        expect(current_path).to eq('/applications/new')
        expect(page).to have_content("City can't be blank")
        expect(page).to have_content("State can't be blank")
        expect(page).to have_content("Zipcode can't be blank")
        expect(page).to have_content("Description can't be blank")
    end 
end