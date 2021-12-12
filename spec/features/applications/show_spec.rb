require 'rails_helper'

RSpec.describe 'application show' do

  it 'shows application' do
    @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    # binding.pry
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
  end

  it 'can search for pets to add to application' do
    @application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: '1')

    visit("/applications/#{@application.id}")
    expect(page).to have_content("Add a Pet to this Application")
    fill_in("Pet name", with: @pet_1.name)
    click_on "Search pets by name"
    # binding.pry
    expect(current_path).to eq("/applications/#{@application.id}")
    save_and_open_page
    expect(page).to have_content(@pet_1.name)
  end
end
