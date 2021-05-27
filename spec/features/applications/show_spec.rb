require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Idaho Humane Society", city: "Boise", rank: 3)
    @shelter_2 = Shelter.create!(foster_program: true, name: "Denver Humane Society", city: "Denver", rank: 1)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: "Mastiff", name: "Sir Willim Wallace")
    @pet_2 = @shelter_1.pets.create!(adoptable: false, age: 1, breed: "German Short Hair", name: "Blazer")
    @pet_3 = @shelter_1.pets.create!(adoptable: false, age: 2, breed: "Newfoundland", name: "Dean")
    @pet_4 = @shelter_2.pets.create!(adoptable: false, age: 4, breed: "Mix Breed", name: "Wanda")
    @pet_5 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: "Mane Coon", name: "Tina")

    @application_1 = Application.create!(name: "George", state: "Idaho", city: "Boise", zip_code: 83616, address: "395 Middle Street", description: "student", status: "Accepted")
    @application_2 = Application.create!(name: "Fred", state: "Idaho", city: "Star", zip_code: 83616, address: "395 State Street", description: "student", status: "Accepted")
    @application_3 = Application.create!(name: "Charlie", state: "Colorado", city: "Nampa", zip_code: 83616, address: "395 Eagle Road", description: "Anthropologist", status: "Pending")
    @application_4 = Application.create!(name: "Bill", state: "Colorado", city: "Kuna", zip_code: 83616, address: "395 Purple Street", description: "student", status: "Accepted")

    PetApplication.create!(pet: @pet_1, application: @application_1)
    PetApplication.create!(pet: @pet_3, application: @application_1)
    PetApplication.create!(pet: @pet_2, application: @application_2)
    PetApplication.create!(pet: @pet_3, application: @application_3)
    PetApplication.create!(pet: @pet_4, application: @application_4)
  end

  it "shows the application and its attributes" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_3.name)
  end

  it "has add a pet to application form" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content("Add a Pet to this Application")
    expect(page).to have_button("Search")
  end


end