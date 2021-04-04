require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do
    @foothills_shelter = Shelter.create!(name: 'Foothills Animal Shelter', 
      city: 'Golden, CO', foster_program: true, rank: 4)
    @rufio = @foothills_shelter.pets.create!(name: 'Rufio', breed: 'hound',
      age: 2, adoptable: true)
    @rug = @foothills_shelter.pets.create!(name: 'Rug',
      breed: 'Australian shepherd', age: 6, adoptable: true)
    @petunia = @foothills_shelter.pets.create!(name: 'Petunia',
      breed: 'chihuahua', age: 1, adoptable: true)

    @hayley_williams = Application.create!(applicant_name: 'Hayley Williams',
      street: "789 Rose St.",
      city: "Golden",
      state: "CO",
      zip_code: "80123",
      statement: " ",
      status: "In Progress"
      )
    # @hayley_williams.pets << @petunia

    @jeff_rosenstock = Application.create!(applicant_name: 'Jeff Rosenstock',
      street: "456 Mississippi Ave.",
      city: "Denver",
      state: "CO",
      zip_code: "80012",
      statement: " ",
      status: "In Progress"
      )
    # @jeff_rosenstock.pets << @lawson

    visit "/applications/#{@hayley_williams.id}"
  end

  it "shows the application and all of it's attributes" do
    expect(page).to have_content(@hayley_williams.applicant_name)
    expect(page).to have_content(@hayley_williams.street)
    expect(page).to have_content(@hayley_williams.city)
    expect(page).to have_content(@hayley_williams.state)
    expect(page).to have_content(@hayley_williams.zip_code)
    expect(page).to have_content(@hayley_williams.statement)
    expect(page).to have_content(@hayley_williams.status)
    expect(page).to_not have_content(@jeff_rosenstock.applicant_name)
  end

  # The Application's status, either "In Progress", "Pending", "Accepted", or
  # Rejected
  it "has a status of 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
    expect(@hayley_williams.status).to eq("In Progress")
  end

  it "has a section on the page to 'Add a Pet to this Application" do
    expect(page).to have_content("Add a Pet to this Application")
  end

  it "has a text box where I can search for pets by name" do
    expect(page).to have_button("Search")
  end

  it "Fill in search field with a Pet's name and click submit, then I am taken\
   back to the application show page. And under the search bar I see any Pet\
   whose name matches my search" do

   fill_in "Search by Pet name", with: "Ru"
   click_on("Search")

   expect(page).to have_content(@rug.name)
   expect(page).to have_content(@rufio.name)
  end

  it "next to each Pet's name I see a button to 'Adopt this Pet', when I click\
   one of these buttons I am taken back to the application show page and\
   I see the Pet I want to adopt listed on this application" do

   end

  it "Has a section to submit my application after I have added one or more\
    pets to the application. And in that section I see an input to enter why I\
    would make a good owner for these pet(s)" do

  end

  #
  #   it "When I fill in that input and I click a button to submit this application\
  #     then I am taken back to the application's show page" do
  #
  #   end
  #
  #   it "And I see an indicator that the application is 'Pending'.\
  #     And I see all the pets that I want to adopt. And I do not see a section\
  #     to add more pets to this application" do
  #
  #   end
  end
