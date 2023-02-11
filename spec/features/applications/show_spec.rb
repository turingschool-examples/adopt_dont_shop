require 'rails_helper'

RSpec.describe 'the applications show page' do
  it "lists an application's attributes and associated pets" do
    shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
    app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",  )
    pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
    petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id)

    visit "/applications/#{app1.id}"
 
    expect(page).to have_content("Name: #{app1.name}")
    expect(page).to have_content("Address: #{app1.street_address}, #{app1.city}, #{app1.state} #{app1.zipcode}")
    expect(page).to have_content("Description: #{app1.description}")
    expect(page).to have_content("Status: #{app1.status}")
    expect(page).to have_content("#{pet1.name}")
    expect(page).to have_link "#{pet1.name}" , href: "/pets/#{pet1.id}" 
  end

  describe 'when visiting show page where application has not been submitted' do 
    it 'has a section to search for a pets name' do 
    shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
    app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
    app2 = Application.create!(name: 'Jake Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
    pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
    pet2 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Benedict McBark', shelter_id: shelter1.id,)
    petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id)
    # petapplication2 = PetApplication.create!(pet_id: nil, application_id: app2.id)

    visit "/applications/#{app2.id}"

    expect(page).to have_content("Add pet to this Application")

    fill_in("Add pet to this Application", with: "Benedict McBark")
    click_button "Search"

    expect(current_path).to eq("/applications/#{app2.id}")
    expect(page).to have_content("Benedict McBark")
    
    end

    it 'search results return buttons to add a pet to the application' do 
      shelter1 = Shelter.create!(foster_program: true, name: 'Pet Friends', city: "Denver", rank: 3)
      app1 = Application.create!(name: 'Matt Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
      app2 = Application.create!(name: 'Jake Smith', street_address: "1101 Main", city: "Denver", state: "CO", zipcode: 55555, description: "I like turtles!", status: "In Progress",)
      pet1 = Pet.create!(adoptable: true, age: 46, breed: 'snapping', name: 'Shelly', shelter_id: shelter1.id, )
      pet2 = Pet.create!(adoptable: true, age: 2, breed: 'husky', name: 'Benedict McBark', shelter_id: shelter1.id,)
      petapplication1 = PetApplication.create!(pet_id: pet1.id, application_id: app1.id)
      # petapplication2 = PetApplication.create!(pet_id: nil, application_id: app2.id)
  
      visit "/applications/#{app2.id}"

      expect(page).to have_content("Add pet to this Application")
  
      fill_in("Add pet to this Application", with: "Benedict McBark")
      click_button "Search"
      expect(current_path).to eq("/applications/#{app2.id}")
      expect(page).to have_content("Benedict McBark")
      end
  end
end