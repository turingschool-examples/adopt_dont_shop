require 'rails_helper'

RSpec.describe 'the application show page' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet_1 = Pet.create(name: 'Duke', age: 17, breed: 'Schnoodle', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(name: 'Marty', age: 9, breed: 'German Shepard', adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create(name: 'Taco', age: 4, breed: 'Malamute', adoptable: true, shelter_id: @shelter.id)
    @pet_4 = Pet.create(name: 'Steven', age: 2, breed: 'Komondor', adoptable: true, shelter_id: @shelter.id)

    @application_1 = Application.create!(name: 'Sebastian Hastings',
                                         street_address: '123 Ilyeria Drive',
                                         city: 'Burnaby',
                                         state: 'California',
                                         zip_code: 88925,
                                         description: 'Do you like cheese?',
                                         status: 'In Progress')

    @pet_application = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
  end

  it 'displays all of the applicants attributes' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
  end
end
