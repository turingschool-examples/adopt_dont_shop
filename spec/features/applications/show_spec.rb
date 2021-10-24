require 'rails_helper'

RSpec.describe 'the application show' do 
  it 'shows the applicant and all its attributes' do 
    @application = Application.create!(name: 'Shaggy Rogers', street_address: '544 Mystery Machine Lane', city: 'Los Angeles', state: 'CA', zip_code: '90210', reason: 'Because I am scared 24/7', status: "rejected")
    @shelter = Shelter.create(name: 'Rescue Paws', city: 'Denver, CO', foster_program: true, rank: 1)
    @pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet2 = Pet.create(name: 'Scrappy', age: 1, breed: 'Mini Great Dane', adoptable: false, shelter_id: @shelter.id)
    
    ApplicationPet.create(application: @application, pet: @pet1)
    ApplicationPet.create(application: @application, pet: @pet2)
    visit "/applications/#{@application.id}"  
    
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street_address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip_code)
    expect(page).to have_content(@application.reason)
    expect(page).to have_content(@application.status)
  end 
end 