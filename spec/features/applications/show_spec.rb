require 'rails_helper'

RSpec.describe 'show page for applications' do
  before(:each) do
    @application = Application.create(name: 'Greg',
                                      address: '123 streetname',
                                      description: 'I good pet owner',
                                      status: 'Pending')
    
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    
    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(name: 'Bob', age: 5, breed: 'Big Boy', adoptable: true, shelter_id: @shelter.id)

    ApplicationPet.create(application: @application, pet: @pet_1)
    ApplicationPet.create(application: @application, pet: @pet_2)
  end

  it 'shows the name of the applicant' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
  end

  it 'shows the address of the applicant' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.address)
  end
end