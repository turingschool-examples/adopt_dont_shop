require 'rails_helper' 
RSpec.decribe 'Starting a new application' do
  visit '/applications/new'

  fill_in 'Name:', with: 'Amy Nelson'
  fill_in 'Street Address:', with: '123 Rainbow rd'
  fill_in 'City:', with: 'Golden'
  fill_in 'State:', with: 'Colorado'
  fill_in 'Zip Code:', with: 80401
  fill_in 'Tell us why your home is a good fit?', with: ' I am literally the bestest ever.'

  click_on 'Submit Application'

  expect(current_path).to eq('/applications')
end