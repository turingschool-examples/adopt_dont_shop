require 'rails_helper'

RSpec.describe 'the applications show page' do
  before :each do
    @application = Application.create!(
      name: "Joel Grant",
      address: "1234 Grant Road",
      description: "I love dogs",
      status: "In Progress"
    )
    @shelter = Shelter.create!(name: "Love Dogs Shelter", city: "Denver", rank: 10, foster_program: true)
    @pet_1 = @shelter.pets.create!(name: "Buster", adoptable: true, age: 2, breed: "Black Lab")
    @pet_2 = @shelter.pets.create!(name: "Minnie", adoptable: false, age: 2, breed: "Chow")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
    visit "/applications/#{@application.id}"
  end

  it 'has the name of the applicant' do
    expect(page).to have_content("#{@application.name}")
  end

  it 'has the full address of the applicant' do
    expect(page).to have_content("#{@application.address}")
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
end
