require 'rails_helper'

RSpec.describe "admin shelters index" do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Cheyenne Animal Shelter', city: 'Cheyenne', foster_program: false, rank: 8)
    @shelter_2 = Shelter.create!(name: 'Fort Collins Humane Society', city: 'Cheyenne', foster_program: true, rank: 2)
    @shelter_3 = Shelter.create!(name: 'Big Dogs Huge Paws', city: 'Fort Collins', foster_program: false, rank: 11)
    @pet_1 = @shelter_1.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true)
    @pet_2 = @shelter_2.pets.create!(name: 'Bianca', age: 3, breed: 'Great Pyrenees',  adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: 'Chibi', age: 10, breed: 'Shiba Inu', adoptable: true)
    @app_1 = Application.create!(
      name: "Sarah Carter",
      address: "1108 Ichabod St",
      city: "North Pole",
      state: "Alaska",
      zip: "99705")
    @app_1.pets << @pet_1
    @app_1.pets << @pet_2

    visit "/admin/shelters"
  end

  it "lists all the shelters in reverse alphabetical order" do
    within '#shelters' do
      expect(@shelter_2.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to appear_before(@shelter_3.name)
    end
  end

  it "only lists shelters with pending applications" do
    within '#shelter-apps' do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to have_no_content(@shelter_3.name)
    end
  end
end
