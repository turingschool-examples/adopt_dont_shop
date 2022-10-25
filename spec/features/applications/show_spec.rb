

require 'rails_helper'

RSpec.describe "Application Show Page" do
  describe "As a visitor" do
    describe "When I visit an applications show" do
      it "Then I can see the applications attributes" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")

        ApplicationPet.create!(pet: becky, application: application)

        visit "/applications/#{application.id}"

        within("#applicant_info") do
          expect(page).to have_content("Bob Smith")
          expect(page).to have_content("1234 Easy St.")
          expect(page).to have_content("Denver")
          expect(page).to have_content("CO")
          expect(page).to have_content(80001)
          expect(page).to have_content("temp description")
          expect(page).to have_content("In Progress")
        end

        within("#pet-#{becky.id}") do
          expect(page).to have_link("Becky")
        end

        click_link "Becky"

        expect(current_path).to eq("/pets/#{becky.id}")
      end
    end

    describe "Searching for pets" do
      before :each do
        @application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        @shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        @becky = @shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")
        @bean = @shelter.pets.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean")
      end

      it "doesn't show search for pets form if application has been submitted" do
        @application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")

        visit "/applications/#{@application.id}"

        within("#app_not_in_progress") do
          expect(page).to_not have_content("Add a Pet to this Application")
        end
      end

      it "can search for pets by name" do
        visit "/applications/#{@application.id}"

        expect(page).to have_content("In Progress")

        within("#search_pet") do
          expect(page).to have_content("Add a Pet to this Application")
          expect(page).to have_button("Submit")

          fill_in(:name, with: "Becky")
          click_button("Submit")

          expect(current_path).to eq("/applications/#{@application.id}")
        end

        within("#pet_find-#{@becky.id}") do
          expect(page).to have_content(@becky.name)
          expect(page).to have_content(@becky.age)
          expect(page).to have_content(@becky.breed)
          expect(page).to_not have_content(@bean.name)
          expect(page).to_not have_content(@bean.breed)
        end
      end

      it "can find pets whose names partially match the search" do
        visit "/applications/#{@application.id}"

        fill_in(:name, with: "Beck")
        click_button("Submit")

        within("#pet_find-#{@becky.id}") do
          expect(page).to have_content(@becky.name)
          expect(page).to have_content(@becky.age)
          expect(page).to have_content(@becky.breed)
        end
      end

      it "can find case insensitive names" do
        visit "/applications/#{@application.id}"

        fill_in(:name, with: "beCk")
        click_button("Submit")

        within("#pet_find-#{@becky.id}") do
          expect(page).to have_content(@becky.name)
          expect(page).to have_content(@becky.age)
          expect(page).to have_content(@becky.breed)
        end
      end
    end

    describe "Adding pets" do
      before :each do
        @application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        @shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        @becky = @shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")
        @bean = @shelter.pets.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean")
      end

      it "can add pets to the application" do
        visit "/applications/#{@application.id}"

        fill_in(:name, with: "Becky")
        click_button("Submit")
        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_button("Adopt this Pet")

        click_button "Adopt this Pet"
        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_link("Becky")
        expect(page).to_not have_content(@becky.breed)
      end
    end

    describe "Submitting the application" do
      it "shows the application submission form if at least one pet is added" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")
        bean = shelter.pets.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean")
        visit "/applications/#{application.id}"

        fill_in(:name, with: "Becky")
        click_button("Submit")
        click_button "Adopt this Pet"

        expect(page).to have_content("Why I would make a good owner")
        fill_in(:description, with: "Test Description")
        click_button("Submit this application")

        expect(current_path).to eq("/applications/#{application.id}")
        expect(page).to have_content("Pending")

        expect(page).to have_content("temp description Test Description")
      end
    end
  end
end
