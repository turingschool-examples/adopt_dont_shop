require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @shelter = Shelter.create!(foster_program: true, name: "shelter_1", city: "Dallas", rank: 1)

    @pet_1 = Pet.create!(adoptable: true, age: 10, breed: "Hound", name: "Pete", shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Newton", shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: false, age: 13, breed: "German Shepard", name: "Molly", shelter_id: @shelter.id)


    @application_1 = Application.create(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "In Progress")

    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_application_3 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)


  end
  it "shows all attributes of the application" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_3.name)
  end

  it "has links to the show page of each pet being applied for" do
    visit "/applications/#{@application_1.id}"
    click_link("#{@pet_1.name}")
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/applications/#{@application_1.id}"
    click_link("#{@pet_2.name}")
    expect(current_path).to eq("/pets/#{@pet_2.id}")

    visit "/applications/#{@application_1.id}"
    click_link("#{@pet_3.name}")
    expect(current_path).to eq("/pets/#{@pet_3.id}")
  end

  it "if application is In Progress, it has a search form for adding pets" do
    application_no_seach_1 = Application.create!(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "Submitted")
    application_no_seach_2 = Application.create!(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "Accepted")
    application_no_seach_3 = Application.create!(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "Rejected")

    visit "/applications/#{application_no_seach_1.id}"
    expect(page).to_not have_content("Search for Pets")
    visit "/applications/#{application_no_seach_2.id}"
    expect(page).to_not have_content("Search for Pets")
    visit "/applications/#{application_no_seach_3.id}"
    expect(page).to_not have_content("Search for Pets")
    visit "/applications/#{@application_1.id}"
    expect(page).to have_content("Search for Pets")
  end

  it 'has a form to add pets to the application using a search bar by pet name' do
    pet_v1 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Newton Curtis", shelter_id: @shelter.id)
    pet_v1 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Curtis Newton", shelter_id: @shelter.id)
    pet_v1 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "McNewtons", shelter_id: @shelter.id)
    pet_v1 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "newton", shelter_id: @shelter.id)
    visit "/applications/#{@application_1.id}"

    within('div.search') do
      fill_in "Search for Pets", with: "Newton"
      click_button "Search"
      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to have_content("Newton")
      expect(page).to have_content("Newton Curtis")
      expect(page).to have_content("Curtis Newton")
      expect(page).to have_content("McNewtons")
      expect(page).to have_content("newton")
      expect(page).to_not have_content("Pete")
    end
  end

  it 'has an adopt this pet button next to each pet found through search' do
    pet_v1 = Pet.create!(adoptable: false, age: 3, breed: "GSP", name: "Newton Curtis", shelter_id: @shelter.id)
    visit "/applications/#{@application_1.id}"

    within('div.search') do
      fill_in "Search for Pets", with: "Newton"
      click_button "Search"
    end
    within("div.pet_#{@pet_2.id}") do
      expect(page).to have_button("Adopt this Pet")
      click_button "Adopt this Pet"
      expect(current_path).to eq("/applications/#{@application_1.id}")
    end
    within("div.pets") do
      expect(page).to have_content("Newton")
    end
  end

  it "has buttom to submit application only if 1 or more pet has been added" do
    app = Application.create!(name: 'Steve', address: '135 Waddle Road', city: 'Dallas', state: 'TX', zip: 75001, description: "I really want a dog", status: "In Progress")
    visit "/applications/#{app.id}"
    expect(page).to_not have_content("Submit this Application")
    expect(page).to_not have_content(app.description)

    within('div.search') do
      fill_in "Search for Pets", with: "Newton"
      click_button "Search"
    end
    within("div.pet_#{@pet_2.id}") do
      click_button "Adopt this Pet"
    end

    within("div.submit") do
      fill_in "Why would you make a good owner?", with: "I really like dogs a lot"
      click_button "Submit"

      expect(current_path).to eq("/applications/#{app.id}")
    end

    expect(page).to have_content("I really like dogs a lot")
    expect(page).to_not have_content("In Progress")
    expect(page).to have_content("Pending")
    expect(page).to_not have_content("Adopt this Pet")
  end

end
