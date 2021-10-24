require 'rails_helper'

RSpec.describe 'the application show' do
  it 'can list application information' do
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    application = Application.create!(name: 'Jim Jimmerson', address: '123 Fake st', city: 'Denver', state: 'CO', zip_code: '90210', good_home: 'I love animals!',  application_status: 'In Progress')
    pet1 = application.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = application.pets.create!(name: 'Mia', age: 3, breed: 'cat', adoptable: true, shelter_id: shelter.id)
    visit "/applications/#{application.id}"
    
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.good_home)
    expect(page).to have_content(pet1.name)
    expect(page).to have_content(pet2.name)
    expect(page).to have_content(application.application_status)
  end
end
