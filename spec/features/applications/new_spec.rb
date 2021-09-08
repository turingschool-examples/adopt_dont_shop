require 'rails_helper'

RSpec.describe 'application show page' do
  before(:each) do
    @app_1 = Application.create!(
      name: "Sarah Carter",
      address: "1108 Ichabod St",
      city: "North Pole",
      state: "Alaska",
      zip: "99705")
    @shelter = Shelter.create!(name: 'Cheyenne Animal Shelter', city: 'Cheyenne', foster_program: false, rank: 2)
    @pet_1 = @shelter.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(name: 'Bianca', age: 1, breed: 'Great Pyrenees',  adoptable: true, shelter_id: @shelter.id)
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2
  end

  it 'renders the new form' do
    visit "/applications/new"

    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip')
  end


  it 'returns to new application and gives error if fields empty' do
    visit "/applications/new"
    click_button 'Submit'
    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("All * fields must be filled in")

    fill_in 'Name', with: 'Ida Olson'
    fill_in 'Address', with: '3009 Ames Court'
    fill_in 'City', with: 'Cheyenne'
    fill_in 'State', with: 'Wyoming'
    click_button 'Submit'

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("All * fields must be filled in")

    fill_in 'Name', with: 'Ida Olson'
    fill_in 'Address', with: '3009 Ames Court'
    fill_in 'City', with: 'Cheyenne'
    fill_in 'State', with: 'Wyoming'
    fill_in 'Zip', with: '82001'
    click_button 'Submit'

    expect(page).to have_content("Application Submitted!")
  end
end
