require 'rails_helper'

RSpec.describe 'the applications show page' do
  it 'lists an applications attributes' do
    shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
    app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",  )
    pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
    petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id)

  
    visit "/applications/#{app1.id}"
    save_and_open_page
    expect(page).to have_content("Name: #{app1.name}")
    expect(page).to have_content("Address: #{app1.street_address}, #{app1.city}, #{app1.state} #{app1.zipcode}")
    expect(page).to have_content("Description: #{app1.description}")
    expect(page).to have_content("Status: #{app1.status}")
    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_link "#{pet1.name}'s Page" , href: "/pets/#{pet1.id}" 
  end
end