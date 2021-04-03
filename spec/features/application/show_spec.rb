require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    Shelter.destroy_all
    Application.destroy_all
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @application = Application.create(name: "Joan", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801)
    @pet1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
  end

    it 'shows the name of the Applicant including street, city, state, and zip code ' do
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip_code)
    # expect(page).to have_content("Pending")
  end

  it 'names all the pets that this application is for' do
    click_link "#{@pet1.name}"
    expect(page).to have_current_path("/pets/#{@pet1.id}/show")
    expect(page).to have_content("pending")
  end

  it 'Search for a Pet for Application' do
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip_code)
    expect(page).to have_content("In Progress")
    expect(page).to have_content("Add a Pet to this Application")
    expect(pafe).to have_field("search for pet")

    fill_in "search for pet", with: "#{@pet1.name}"
    click_button "search"
    expect(page).to have_current_path

    expect(page).to have_content("#{@pet1.name}")
    expect(page).to_not have_content("#{@pet2.name}")
  end

  it 'It can add a pet to an applicaton' do
    visit "/applications/#{@application.id}"
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    click_button "search"
    #Look into what page it goes to
    expect(page).to have_content(@pet1.name)
    click_button "Adopt #{@pet1.name}"
    expect(page).to have_current_path

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.pet_wanted)
    expect(page).to have_content(@pet1.name)
  end

  it 'Submit an Application' do
    fill_in :description, with: "I have another cat"
    click_button('submit application')
  end

  it 'Unable to submit 'do
    expect(page).to_not have_content("Submit")
  end
end
