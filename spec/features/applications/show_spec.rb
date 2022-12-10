require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @app1 = Application.create(name: "Max", street_address: "Made up St", city: "Denver", state: "CO", zip_code: "80000", description: "Love mix breeds. Lots of energy to play with a dog", status: "In Progress")
    @app2 = Application.create(name: "Alastair", street_address: "Fictional St", city: "Golden", state: "CO", zip_code: "80001", description: "Love big dogs. Great mountain walks on doorstep", status: "Accepted")
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet1 = @app1.pets.create(name: 'Noodle', age: 2, breed: 'Border Collie', adoptable: true, shelter_id: @shelter.id)
    @pet2 = @app1.pets.create(name: 'Hercules', age: 2, breed: 'American Akita', adoptable: true, shelter_id: @shelter.id)
  end
  

  it 'shows the application and all its attributes' do
    visit "/applications/#{@app1.id}"
    
    expect(page).to_not have_content(@app2.name)
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    expect(page).to have_link(@pet1.name)
    expect(page).to have_link(@pet2.name)
    
    click_link(@pet2.name)
    expect(page).to have_current_path("/pets/#{@pet2.id}")
  end
end