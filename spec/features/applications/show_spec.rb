require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays the applicants attributes' do
    application = Application.create!(name: 'Jenn', address: '123 Water Street, Denver, CO, 80111',
                                      description: 'I like animals!', status: 'In Progress')
    visit "/applications/#{application.id}"
    expect(page).to have_content('Jenn')
    expect(page).to have_content('123 Water Street, Denver, CO, 80111')
    expect(page).to have_content('I like animals!')
    expect(page).to have_content('In Progress')
  end

  it 'displays names of pets for application' do
    shelter = Shelter.create!(foster_program: true, name: 'Happy Dog', city: 'Denver', rank: 3)
    max = shelter.pets.create!(adoptable: true, age: 4, breed: 'Labrador', name: 'Max')
    sasha = shelter.pets.create!(adoptable: false, age: 2, breed: 'Pitsky', name: 'Sasha')
    application = Application.create!(name: 'Thomas', address: '12 Water Street, Denver, CO, 80111',
                                      description: 'Happy Home', status: 'In Progress')
    application2 = Application.create!(name: 'Sage', address: '42 Wind Avenue, Denver, CO, 80111',
                                       description: 'Happy home', status: 'In Progress')
    ApplicationPet.create!(pet: max, application: application)
    ApplicationPet.create!(pet: sasha, application: application)
    ApplicationPet.create!(pet: sasha, application: application2)
    visit "/applications/#{application.id}"
    expect(page).to have_content('Max')
    expect(page).to have_content('Sasha')
    click_link 'Max'
    expect(current_path).to eq("/pets/#{max.id}")
    visit "/applications/#{application.id}"
    click_link 'Sasha'
    expect(current_path).to eq("/pets/#{sasha.id}")
  end
end
