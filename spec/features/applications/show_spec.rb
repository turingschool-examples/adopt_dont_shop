require 'rails_helper'

RSpec.describe 'the applications show page' do
  before :each do
    @application = Application.create!(
      name: "Joel Grant",
      street_address: "1234 Grant Road",
      city: "Littleton",
      state: "Colorado",
      zip: "80120"
      # description: "I love dogs"
    )
    @shelter = Shelter.create!(name: "Love Dogs Shelter", city: "Denver", rank: 10, foster_program: true)
    @pet_1 = @shelter.pets.create!(name: "Buster", adoptable: true, age: 2, breed: "Black Lab")
    @pet_2 = @shelter.pets.create!(name: "Minnie", adoptable: false, age: 2, breed: "Chow")
    @pet_3 = @shelter.pets.create!(name: "Busted", adoptable: true, age: 6, breed: "Bulldog")
    # ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    # ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
    visit "/applications/#{@application.id}"
  end

  it 'has the name of the applicant' do
    expect(page).to have_content("#{@application.name}")
  end

  it 'has the full address of the applicant' do
    expect(page).to have_content("#{@application.street_address}")
  end

  it 'has the description why the applicant wants to adopt' do
    expect(page).to have_content("#{@application.description}")
  end

  it 'has the application status' do
    expect(page).to have_content("#{@application.status}")
  end

  it 'has an application status that can only be In Progress, Pending, Accepted, and Rejected' do
    expect(@application.status).to eq("In Progress").or eq("Pending").or eq("Accepted").or eq("Rejected")
  end

  it 'has a search box to find a pet to add to the application' do
    fill_in(:search_pets, with: "Bust")
    click_button "Submit"

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_3.name}")
    expect(page).to_not have_content("#{@pet_2.name}")
  end

  it 'has a button to select which pet to adopt' do

    fill_in(:search_pets, with: "Bust")
    click_button "Submit"

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_3.name}")
    expect(page).to_not have_content("#{@pet_2.name}")

    click_link "Adopt #{@pet_1.name}"
    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to_not have_content("#{@pet_2.name}")
    expect(page).to_not have_content("#{@pet_3.name}")
  end

  it 'has a section to input a description and a button to submit the application' do # could be split up?
    fill_in(:search_pets, with: "Bust")
    click_button "Submit"

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to have_content("#{@pet_3.name}")
    expect(page).to_not have_content("#{@pet_2.name}")

    click_link "Adopt #{@pet_1.name}"

    expect(page).to have_content("#{@pet_1.name}")
    expect(page).to_not have_content("#{@pet_2.name}")
    expect(page).to_not have_content("#{@pet_3.name}")

    fill_in(:search_pets, with: "Minnie")
    click_button "Submit"

    expect(page).to have_content("#{@pet_2.name}")

    click_link "Adopt #{@pet_2.name}"

    fill_in(:description, with: "Cuz I love animals")
    click_button "Submit Application"
  end

  it 'will not have a description field if the user hasnt added any pets to the application' do
    expect(page).to have_field(:description, disabled: true)
    expect(page).to have_button("Submit Application", disabled: true)
  end
end
