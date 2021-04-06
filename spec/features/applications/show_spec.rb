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

    @jeff_rosenstock = Application.create!(applicant_name: 'Jeff Rosenstock',
      street: "456 Mississippi Ave.",
      city: "Denver",
      state: "CO",
      zip_code: "80012",
      statement: " ",
      status: "In Progress"
      )

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

    fill_in "Search by Pet name", with: "Ru"
    click_on("Search")

    expect(page).to have_button("Adopt this Pet")

    within "#pet_search_result-#{@rug.id}" do
      expect(page).to have_content(@rug.name)
      click_on("Adopt this Pet")
    end

    expect(page).to_not have_content(@rufio.name)
  end

  it "Has a section to submit my application after I have added one or more\
    pets to the application. And in that section I see an input to enter why I\
    would make a good owner for these pet(s)" do

    fill_in "Search by Pet name", with: "Ru"
    click_on("Search")

    within "#pet_search_result-#{@rug.id}" do
      click_on("Adopt this Pet")
    end

    expect(page).to have_content(@rug.name)
    expect(page).to_not have_content(@rufio.name)
    expect(page).to have_content("Why would you make a good owner for the selected pet(s)?")

    expect(page).to have_button("Submit Application")
  end


  describe "When I fill in that input and I click a button to submit this application\
    then I am taken back to the application's show page" do
    it "And I see an indicator that the application is 'Pending'.\
      And I see all the pets that I want to adopt. And I do not see a section\
      to add more pets to this application" do

      fill_in "Search by Pet name", with: "Ru"
      click_on("Search")

      within "#pet_search_result-#{@rug.id}" do
        click_on("Adopt this Pet")
      end

      fill_in "", with: "I have a fenced-in yard"
      click_on("Submit Application")

      expect(page).to have_content("Application Status: Pending")
      expect(page).to have_content(@rug.name)
      expect(page).to_not have_content("Why would you make a good owner for the selected pet(s)?")
      expect(page).to_not have_button("Search")
      expect(page).to_not have_button("Adopt this Pet")
    end
  end
end
