require 'rails_helper'

RSpec.describe 'applicant information' do 
  before :each do
    @application = Application.create!(name: 'Murph', street: '123 Apple St', city: 'Boca Raton', state: 'FL', zip: 33498, description: 'I want Jack', status: 'in progress')
    @shelter_1 = Shelter.create!(name: 'Pups and Suds', city: 'Fort Collins', foster_program: false, rank: 2)
    @pet1 = @shelter_1.pets.create!(name: 'Jack', age: 4, breed: 'Australian Shepherd', adoptable: true)
    @pet2 = @shelter_1.pets.create!(name: 'Cooper', age: 3, breed: 'Golden Retriever', adoptable: true)
  end

  it 'displays applicant information' do
    visit "/applications/#{@application.id}"
    
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
  end

  it 'adds and searches for pets' do
    visit "/applications/#{@application.id}"

    expect(page).to have_button("Show Me the Cuddles!")

    fill_in :search, with: "#{@pet1.name}"
    click_button "Show Me the Cuddles!"

    expect(page).to have_content("#{@pet1.name}")
  end
end