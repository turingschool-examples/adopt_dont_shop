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
    @id = Petition.last.id
  end
  it 'displays applicant name and address' do
    expect(page).to have_content('Your name: Ted Leo')
    expect(page).to have_content('Your address: 123 Pharmacist Ln Denver, CO 80210')
    expect(page).to have_content('In Progress')
  end

  it 'displays option to search for pets and add to petition' do
    expect(page).to have_content('Add a Pet to this Application')
  end

  it 'searching returns a list of pets on existing show page' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Fluffy', shelter_id: shelter.id)
    fill_in 'Add a Pet to this Application', with: 'Fluffy'
    click_button 'Search'

    expect(current_path).to eq "/petitions/#{@id}"
    expect(page).to have_content('Fluffy')
    expect(page).not_to have_content('Lucille Bald')
  end
end
