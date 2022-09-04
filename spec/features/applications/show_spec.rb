require 'rails_helper'

RSpec.describe 'the applications show page' do
  describe 'as a user, when I visit /applications/:id' do
    before(:each) do
      @application = Application.create!(first_name: "Jon", last_name: "Duttko", str_address: "1018 O St NW", city: "Washington", state: "DC", zip: 20001, home_description: "friendly", status: "Pending")
      @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
      @application.pets << @pet_1
      @pet_2 = Pet.create(name: 'Indy', age: 4, breed: 'Mutt', adoptable: true, shelter_id: @shelter.id)
      @pet_3 = Pet.create(name: 'Tony', age: 128, breed: 'Tortoise', adoptable: true, shelter_id: @shelter.id)

    end

    it "I see the application and all it's attributes" do

      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.first_name)
      expect(page).to have_content(@application.last_name)
      expect(page).to have_content(@application.str_address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip)
      expect(page).to have_content(@application.home_description)
      expect(page).to have_content(@application.status)
    end

    it "I see links for all the pet names that this application is for" do

      visit "/applications/#{@application.id}"

      expect(page).to have_link(href: "/pets/#{@pet_1.id}")

    end
    it 'returns partial matches for my search' do

      visit "/applications/#{@application.id}"

      fill_in("search", with: "In")
      click_on("Search Pets")

      expect(page).to have_content("Indy")
      expect(page).to have_button("Adopt #{@pet_2.name}")

      expect(page).to_not have_content("Tony")
      expect(page).to_not have_button("Adopt #{@pet_3.name}")
    end
    it 'has a case insensitive search' do
      visit "/applications/#{@application.id}"

      fill_in("search", with: "indy")
      click_on("Search Pets")

      expect(page).to have_content("Indy")
      expect(page).to have_button("Adopt #{@pet_2.name}")

      expect(page).to_not have_content("Tony")
      expect(page).to_not have_button("Adopt #{@pet_3.name}")
    end
  end
end
