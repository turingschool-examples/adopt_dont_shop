require 'rails_helper'

RSpec.describe 'Application show page' do
  before :each do
    @shelter = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha")

    @pet_1 = @shelter.pets.create!(name: "King Trash Mouth", age: 14)
    @pet_2 = @shelter.pets.create!(name: "Princess Dumptruck", age: 18)
    @pet_3 = @shelter.pets.create!(name: "Eggs Sinclair", age: 10)
    @pet_4 = @shelter.pets.create!(name: "Monster Truck Wendy", age: 5)

    @app = App.create!(
      name: "Gob Beldof", 
      address: "152 Animal Ave.", 
      city: "Omaha", 
      state: "NE", 
      zip_code: "19593",
      description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
      status: "In Progress"
    )

    @app.pets << @pet_2
    @app.pets << @pet_3

    visit "apps/#{@app.id}"
  end

  it 'displays the attributes of the selected application' do
    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip_code)
    expect(page).to have_content(@app.description)
    expect(page).to have_link(@pet_2.name)
    expect(page).to have_link(@pet_3.name)
    expect(page).to_not have_link(@pet_1.name)
    expect(page).to_not have_link(@pet_4.name)
    expect(page).to have_content(@app.status)
  end

  describe 'if the application has not been submitted' do
    it 'shows a field to search for adoptable pets' do
      expect(page).to have_content("In Progress")

      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field("Search")

      fill_in("Search", with: "#{@pet_1.name}")
      click_on("Submit")

      expect(current_path).to eq("/apps/#{@app.id}")
      expect(page).to have_content(@pet_1.name)
    end
    
    it 'ignores case and finds partial matches' do
      fill_in("Search", with: "king")
      click_on("Submit")
      expect(page).to have_content(@pet_1.name)

      fill_in("Search", with: "wend")
      click_on("Submit")
      expect(page).to have_content(@pet_4.name)

    it 'shows a list of all pets currently interested in adopting' do
      within("#pets_wanted") do
        @app.pets.each do |pet|
          expect(page).to have_content(pet.name)
          expect(page).to have_content(pet.age)
        end
        expect(page).to_not have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_1.age)
        expect(page).to_not have_content(@pet_4.name)
        expect(page).to_not have_content(@pet_4.age)
      end
      
    end

    it 'can add pets' do
      fill_in("Search", with: "#{@pet_1.name}")
      click_on("Submit")
      within("#pet_#{@pet_1.id}") do
        click_on("Adopt this pet")
      end
      expect(current_path).to eq("/apps/#{@app.id}")
      expect(@app.pets).to include(@pet_1)
      within("#")
    end
  end
end