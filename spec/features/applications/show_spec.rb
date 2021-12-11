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
    @pet_1 = @application_1.pets.create!(adoptable: true,
                                age: 5,
                                breed: "Llama",
                                name: "Cribonis",
                                shelter_id: @shelter_1.id)
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

  it "displays links to each pet name" do
    visit "/applications/#{@application_1.id}"
    expect(page).to have_link("Cribonis")
  end

  it "links to the pet show page when its link is clicked" do
    visit "/applications/#{@application_1.id}"
    click_link("Cribonis")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it "displays a form to add pet if the application has not been submitted" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("Search for pets by name")
  end

  it "routes to filtered pet index searched by name" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Submit")
    expect(current_path).to eq("/applications/#{@application_1.id}")
    expect(page).to have_content("Luke")
  end

  it "has button to adopt after filtering by name" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Submit")
    save_and_open_page
    expect(page).to have_button("Adopt This Pet")
  end

  xit "button to adopt a pet routes back to show page" do
    visit "/applications/#{@application_1.id}"
    fill_in :search, with: "Luke"
    click_button("Submit")
    click_button("Adopt This Pet")
    expect(current_path).to eq("/applications/#{@application_1.id}")

  xit "adopt pet through adopt button" do
  end
  end



end