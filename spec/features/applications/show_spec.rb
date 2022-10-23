require 'rails_helper'

RSpec.describe "the application show page" do 
  before :each do 
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @jeff = @pirate.applications.create!(applicant: "Jeff", reason: "Lonely", status: "In Progress", street: "5155 Heritage Lane", city: "Alexandria", state: "VA", zipcode: "22314")
  end

  it "displays the applicant's name" do 
    visit "/applications/#{@jeff.id}"
  
    expect(page).to have_content("Jeff")
    expect(page).to have_content("Lonely")
    expect(page).to have_content("In Progress")
    expect(page).to have_content("5155 Heritage Lane, Alexandria, VA 22314")
    expect(page).to have_content("Mr. Pirate")
    expect(page).to_not have_content("Lucille Bald")

    #lucille = @jeff.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @jeff.pets << @lucille
    visit "/applications/#{@jeff.id}"
   
    expect(page).to have_content("Lucille Bald")
  end

  it 'displays a section to add pets to the application' do 
    visit "/applications/#{@jeff.id}"

    expect(@jeff.status).to eq("In Progress")
    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_field("search")
    expect(page).to have_button("Search")

    fill_in "search", with: "Clawdia"
    click_on "Search"

    expect(current_path).to eql("/applications/#{@jeff.id}")
    expect(page).to have_content(@clawdia.name)
  end

  it 'has a button that allows users to adopt a pet' do 
    visit "/applications/#{@jeff.id}"
    clawdia_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'longhair', age: 3, adoptable: true)

    fill_in "search", with: "Clawdia"
    click_on "Search"

    expect(page).to have_content("Clawdia", count: 2)
    expect(page).to have_button("Adopt this Pet", count: 2)
  end

  it "when the 'Adopt this Pet' button is clicked" do 
    visit "/applications/#{@jeff.id}"
    expect(page).to_not have_content(@clawdia.name)

    fill_in "search", with: "Clawdia"
    click_on "Search"

    click_on "Adopt this Pet"
    visit "/applications/#{@jeff.id}"
    
    expect(page).to have_content(@clawdia.name)
  end

  it "displays a section to submit an application only when there are pets on the application" do
    abbas = Application.create!(applicant: "Abbas", reason: "neighbour getting pet", status: "In Progress", street: "5157 Heritage Lane", city: "Alexandria", state: "VA", zipcode: "22314")

    visit "/applications/#{abbas.id}"
    expect(page).to_not have_content("Submit Application")
    expect(page).to_not have_button("Submit Application")

    visit "/applications/#{@jeff.id}"
    
    expect(page).to have_content("Submit Application")
    expect(page).to have_button("Submit Application")
  end

  it "cannot have pets added to it once application is submitted" do
    visit "/applications/#{@jeff.id}"

    fill_in "reason", with: "bla"
    click_on "Submit Application"
    
    expect(current_path).to eql("/applications/#{@jeff.id}")
    expect(page).to_not have_content("Submit Application")
    expect(page).to_not have_button("Search")
    expect(page).to_not have_button("Adopt this Pet")
  end
end