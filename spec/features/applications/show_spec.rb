require 'rails_helper'

RSpec.describe 'Applications show page:' do
  before(:each) do
    @application_2 = Application.create!(first_name: "Sam", last_name: "Smith", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, status: "In Progress")
    @application_1 = Application.create!(first_name: "Jon", last_name: "Duttko", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, home_description: "friendly", status: "In Progress")
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(name: 'Indy', age: 4, breed: 'Mutt', adoptable: true, shelter_id: @shelter.id)
    @pet_3 = Pet.create(name: 'Tony', age: 128, breed: 'Tortoise', adoptable: true, shelter_id: @shelter.id)
  end
  describe 'as a user, when I visit /applications/:id' do
    it "I see the application and all it's attributes" do

      visit "/applications/#{@application_2.id}"

      expect(page).to have_content(@application_2.first_name)
      expect(page).to have_content(@application_2.last_name)
      expect(page).to have_content(@application_2.str_address)
      expect(page).to have_content(@application_2.city)
      expect(page).to have_content(@application_2.state)
      expect(page).to have_content(@application_2.zip)
      expect(page).to have_content(@application_2.home_description)
      expect(page).to have_content(@application_2.status)
      expect(page).to have_content("In Progress")
    end

    it "does not allow me to submit an application with no pets" do

      visit "/applications/#{@application_2.id}"

      expect(page).to_not have_content("Indy")
      expect(page).to_not have_button("Submit Application")
    end

    it "I see links for all the pet names that this application is for" do

      visit "/applications/#{@application_2.id}"

      fill_in("search", with: "Indy")
      click_on("Search Pets")
      
      click_on("Adopt #{@pet_2.name}")

      expect(page).to have_link(href: "/pets/#{@pet_2.id}")
      expect(page).to_not have_link(href: "/pets/#{@pet_1.id}")
    end
    it 'returns partial matches for my search' do

      visit "/applications/#{@application_2.id}"

      fill_in("search", with: "In")
      click_on("Search Pets")

      expect(page).to have_content("Indy")
      expect(page).to have_button("Adopt #{@pet_2.name}")

      expect(page).to_not have_content("Tony")
      expect(page).to_not have_button("Adopt #{@pet_3.name}")
    end
    it 'has a case insensitive search' do
      visit "/applications/#{@application_2.id}"

      fill_in("search", with: "indy")
      click_on("Search Pets")

      expect(page).to have_content("Indy")
      expect(page).to have_button("Adopt #{@pet_2.name}")

      expect(page).to_not have_content("Tony")
      expect(page).to_not have_button("Adopt #{@pet_3.name}")
    end
  end 
  describe 'when I have added one or more pets to my application' do
    it 'then I see a section to submit my application' do
      
      visit "/applications/#{@application_2.id}"
      
      fill_in("search", with: "indy")
      click_on("Search Pets")
      click_on("Adopt #{@pet_2.name}")
      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_link("#{@pet_2.name}")

      fill_in("Home description", with: "fenced in yard")
      click_button("Submit Application")

      expect(current_path).to eq("/applications/#{@application_2.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("#{@pet_2.name}")
      expect(page).to have_content("#{@application_2.home_description}")
      expect(page).to_not have_button("Search Pets")
    end
  end
end
