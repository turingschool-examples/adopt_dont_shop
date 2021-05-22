# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'petition show' do
  before :each do
    visit '/petitions/new'
    fill_in 'Name', with: 'Ted Leo'
    fill_in 'Street Address', with: '123 Pharmacist Ln'
    fill_in 'City', with: 'Denver'
    fill_in 'State', with: 'CO'
    fill_in 'Zipcode', with: '80210'
    click_button 'Start Application'
  end
  it 'displays applicant name and address' do
    expect(page).to have_content('Your name: Ted Leo')
    expect(page).to have_content('Your address: 123 Pharmacist Ln Denver, CO 80210')
    expect(page).to have_content('In Progress')
  end
end
