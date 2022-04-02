require 'rails_helper'


RSpec.describe 'the applications index' do
  it 'displays the applicant attributes ' do
    application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = application.pets.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = application.pets.create(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_3 = Pet.create(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    visit "/applications/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zipcode)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to_not have_content(pet_3.name)
    click_link "#{pet_1.name}"
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
end
