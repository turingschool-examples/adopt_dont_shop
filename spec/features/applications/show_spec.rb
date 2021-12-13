require 'rails_helper'
RSpec.describe "the applications show page" do
  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true,
                                name: "Visalia Animal Shelter",
                                city: "Visalia, CA",
                                rank: 10
                                )
    @application_1 = Application.create!(name: "Chris",
                                        street_address: "19072",
                                        city: "Exeter",
                                        state: "CA",
                                        zip: 93221,
                                        description: "I love llamas",
                                        )

    @pet_2 = Pet.create!(adoptable: true,
                                          age: 7,
                                          breed: "Dog",
                                          name: "Luke",
                                          shelter_id: @shelter_1.id)
  end

  it "displays the application information" do
    visit "/applications/#{@application_1.id}"
    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
  end


  it "displays a form to add pet if the application has not been submitted" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("Search for pets by name")
  end

  it "does not allow for submission if no pets exist on the application" do
    visit "/applications/#{@application_1.id}"
    save_and_open_page
    expect(page).to_not have_content("What mkaes you a good owner?")
    expect(page).to_not have_content("Submit?")
  end



  it "routes to filtered pet index searched by name" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Search")
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("Luke")
  end

  it "has button to adopt after filtering by name" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Search")
    expect(page).to have_button("Adopt This Pet")
  end

  it "button to adopt a pet routes back to show page" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Search")
    click_button("Adopt This Pet")
    expect(current_path).to eq("/applications/#{@application_1.id}")
  end

  it "adopt pet through adopt button" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Search")
    click_button("Adopt This Pet")
    expect(@application_1.pets).to eq([@pet_2])
  end


  describe "submit application" do
    before(:each) do
      visit "/applications/#{@application_1.id}"
      fill_in :search, with: "Luke"
      click_button("Search")
      click_button("Adopt This Pet")
    end

  it "links to submit application is status is in progress and the application has pets" do
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("What makes you a good owner?")
  end

  it "links to the pet show page when its link is clicked" do
      visit "/applications/#{@application_1.id}"
      click_link("Luke")
      expect(current_path).to eq("/pets/#{@pet_2.id}")
  end

  it "can adopt multiple pets and submit" do
    @pet_1 = Pet.create!(adoptable: true,
                                          age: 7,
                                          breed: "Llama",
                                          name: "Cribonis",
                                          shelter_id: @shelter_1.id)
    fill_in :search, with: "Cribonis"
    click_button("Search")
    click_button("Adopt This Pet")
    fill_in :description, with: "I love llamas"
    click_button("Submit")
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(@application_1.pets.count).to eq(2)
    expect(@application_1.pets).to eq([@pet_2, @pet_1])
    expect(page).to have_link("Luke")
    expect(page).to have_link("Cribonis")
    expect(page).to have_content("Status: Pending")

  end


    #add tests for filling in form and expectations
  end



end