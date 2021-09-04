require 'rails_helper'

RSpec.describe 'new page' do
  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Best Shelter", city: "Daytona", rank: 4)
    @application_1 = Application.create!(name: "Freddy Thomas", street: "123 Sesame Street", city: "Daytona", state: "FL", zip_code: "12345", description: "I really love dogs", status: "Pending")
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 6, breed: "Pug", name: "Lucy")
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "Labradoodle", name: "Leo")
    PetApplication.create!(application: @application_1, pet: @pet_1)
    PetApplication.create!(application: @application_1, pet: @pet_2)
  end

  it 'has an application for a new pet' do
    visit "/applications/new"
    fill_in :name, with: 'Sara Pounds'
    fill_in :street, with: "2200 W Petty Dr"
    fill_in :city, with: 'Muncie'
    fill_in :state, with: 'IN'
    fill_in :zip_code, with: '47304'
    click_on "Submit"
    expect(current_path).to eq("/applications/#{Application.last.id}")
  end

  it 'displays an error if the application is submitted incomplete' do
    visit "/applications/new"
    fill_in :street, with: "2200 W Petty Dr"
    fill_in :city, with: 'Muncie'
    fill_in :state, with: 'IN'
    fill_in :zip_code, with: '47304'
    click_on "Submit"
    expect(page).to have_content("Error: Name can't be blank")
  end
end
