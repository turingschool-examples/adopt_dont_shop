require 'rails_helper'

RSpec.describe "Application Show Page" do

  before :each do
    @application_1 = Application.create!(name: 'Alex Horn', street_address: '12 Not A Real Ln', city: 'Westminster', state: 'CO', zipcode: '80021', why_me: "Well, I guess, I just REALLY really wanted a dog.")
    @application_2 = Application.create!(name: 'Bob Ross', street_address: '21 Happy Tree Ln', city: 'Daytona Beach', state: 'FL', zipcode: '32122', why_me: "I live on a happy little farm on the edge of town, we've got plenty of space to let the poor feller run and solve mysteries.")
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create!(name: 'Daisy', age: 4, breed: 'American Bully', adoptable: true, shelter_id: @shelter.id)
    @pet_applications_1 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
    @pet_applications_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_applications_3 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_2.id)

  end

  it "Links from pets index to new application form" do
    visit "/pets/"
    click_on "Start an Application"

    expect(current_path).to eq("/applications/new/")

    fill_in :name, with: "John Wick"
    fill_in :street_address, with: "121 Chambers St"
    fill_in :city, with: "New York City"
    fill_in :state, with: "NY"
    fill_in :zip_code, with: "19503"
    click_on :submit

    expect(page).to have_content("John Wick")
    expect(page).to have_content("121 Chambers St")
    expect(page).to have_content("New York City")
    expect(page).to have_content("NY")
    expect(page).to have_content("19503")
    # At this point, we should not have a description of why this applicant wants
    # a pet, but... the user story wants us to have one displayed?
    expect(page).to have_content("In Progress")
  end


end
