require 'rails_helper'

RSpec.describe 'Application #new view' do 
    it 'has a form that allows the user to create a new application' do 
        visit '/application/new'
        fill_in 'name', with: 'Ron'
        fill_in 'street_address', with: '19 Dart'
        fill_in 'city', with: 'Redlands'
        fill_in 'state', with: 'CA'
        fill_in 'zipcode', with: '93003'
        fill_in 'description', with: "I've fallen in love with this dog"
        click_button 'Submit Application'
    end 
end