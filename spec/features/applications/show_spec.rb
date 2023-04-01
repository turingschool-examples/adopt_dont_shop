require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do 
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @application_1 = @pet_1.applications.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      status: "In Progress",
      description: "I like pets",
  )

  @application_5 = Application.create!(
    name: "Charlie Puth",
    street_address:  "124 Main St",
    city: "Aurora",
    state: "CO",
    zip: "80012",
    description: "I like pets even more",
    status: "Pending"
  )

   @application_3 = Application.create!(
   name: "Jorge King",
   street_address:  "333 Round Blvd.",
   city: "Sacramento",
   state: "CA",
   zip: "90071",
   status: "Rejected",
   description: "I LOVE pets",
)
  @application_4 = Application.create!(
    name: "Jorge King",
    street_address:  "333 Round Blvd.",
    city: "Sacramento",
    state: "CA",
    zip: "90071",
    status: "In Progress",
    description: "I LOVE pets",
 )
 @application_5 = Application.create!(
  name: "Charlie Puth",
  street_address:  "124 Main St",
  city: "Aurora",
  state: "CO",
  zip: "80012",
  description: "I like pets even more",
  status: "Pending"
)
  end

  it 'shows the name, description, pets, app status' do
    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_content("#{@application_1.name}")
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@application_1.status}")
  end

  it 'shows address' do
    visit "/applications/#{@application_1.id}"
    expect(page).to have_content("#{@application_1.street_address}, #{@application_1.city} #{@application_1.state} #{@application_1.zip}")
  end

  it 'links to pet page' do
    visit "/applications/#{@application_1.id}"

    click_link("#{@pet_1.name}")


    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "doesn't have submit button" do
    visit "/applications/#{@application_5.id}"

    expect(page).not_to have_button("Submit Application")
  end

  it 'has a submit button and submits application' do
    visit "/applications/#{@application_1.id}"
    
    expect(page).to have_button("Submit Application")

    fill_in 'description', with: "Because, obviously"

    click_button "Submit Application"

    expect(page).to have_current_path("/applications/#{@application_1.id}")
    expect(page).to have_content("Pending")
  end


  #User Story 4
  describe "When i visit /applications/:id" do

    it "displays a section to add a pet if application has not been submitted" do
      visit "/applications/#{@application_4.id}"
      expect(page).to have_content("Add a Pet to this Application")

      visit "/applications/#{@application_3.id}"
      expect(page).to_not have_content("Add a Pet to this Application")
    end

    it "displays an input to search for pets by name" do
      visit "/applications/#{@application_4.id}"
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field(:Name)
      expect(page).to have_selector(:button, "Search")
    end
    it "filling and submitting search redirects to /applications/:id and displays results" do
      visit "/applications/#{@application_4.id}"
      fill_in(:Name, :with => 'Lobster')
      click_on("Search")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_content("Adoptable: true")
      expect(page).to have_content("Age: 3")
      expect(page).to have_content("Breed: doberman")
      expect(page).to have_content("Name: Lobster")
    end
  end

  #User Story 5
  describe "When i visit /applications/:id" do
    it "displays pets that match search and a button 'Adopt this Pet'" do
      visit "/applications/#{@application_4.id}"
      fill_in(:Name, :with => 'Lobster')
      click_on("Search")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_content("Adoptable: true")
      expect(page).to have_content("Age: 3")
      expect(page).to have_content("Breed: doberman")
      expect(page).to have_content("Name: Lobster")
      expect(page).to have_selector(:button, "Adopt this Pet")
    end

    it "clicking takes me back to /applications/:id with pet listed on application" do
      visit "/applications/#{@application_4.id}"
      fill_in(:Name, :with => 'Lobster')
      click_on("Search")
      click_on("Adopt this Pet")
      expect(page).to have_current_path("/applications/#{@application_4.id}")
      expect(page).to have_content("Pets: Lobster")
      expect(page).to have_content("App Status: In Progress")
    end
  end
  
end

