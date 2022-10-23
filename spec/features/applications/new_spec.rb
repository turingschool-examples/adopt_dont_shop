require "rails_helper"

RSpec.describe "creating a new application" do

  it 'the pet index page has a link to start an application' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_link("Start an Application")

    click_link "Start an Application"

    expect(current_path).to eq("/applications/new")
    have_selector("form")

    fill_in :name, with: "James White"
    fill_in :street_address, with: "4512 Blue Bird Ct"
    fill_in :city, with: "Bend"
    select "OR", from: :state
    fill_in :zip, with: 77904
    # fill_in :description, with: "I love dogs"

    click_on "Submit"

    application = Application.last

    expect(current_path).to eq("/applications/#{application.id}") 
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content("In Progress") # readdress later after user story 12
    
    # expect(page).to_not have_content(application.description)
  end

  it 'will not create a new application when fields are left black and will redirect back 
    to the new application page with a message to fill out incomplete fields' do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

      visit "/applications/new"
      have_selector("form")

      fill_in :street_address, with: "4512 Blue Bird Ct"

      click_on "Submit"
      
      expect(current_path).to eq("/applications/new") 
      expect(page).to have_content("Unable to complete your application, please fill out all fields")
      have_selector("form")
  end 
end