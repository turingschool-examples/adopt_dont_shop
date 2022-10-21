

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
        
        expect(page).to have_content("Bob Smith")
        expect(page).to have_content("1234 Easy St.")
        expect(page).to have_content("Denver")
        expect(page).to have_content("CO")
        expect(page).to have_content(80001)
        expect(page).to have_content("temp description")
        expect(page).to have_content("In Progress")
        expect(page).to have_link("Becky")

        click_link "Becky"

        expect(current_path).to eq("/pets/#{becky.id}")
      end
    end
    describe "Searching for pets" do
      it "doesn't show search for pets form if application has been submitted" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")
        bean = shelter.pets.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean")
        visit "/applications/#{application.id}"

        expect(page).to_not have_content("Add a Pet to this Application")

      end
      it "can search for pets by name" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")
        bean = shelter.pets.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean")

        # ApplicationPet.create!(pet: becky, application: application)
        # ApplicationPet.create!(pet: bean, application: application)

        visit "/applications/#{application.id}"

        expect(page).to have_content("In Progress")
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_button("Submit")

        fill_in(:name, with: "Becky")
        click_button("Submit")
        expect(current_path).to eq("/applications/#{application.id}")

        expect(page).to have_content(becky.name)
        expect(page).to have_content(becky.age)
        expect(page).to have_content(becky.breed)
        expect(page).to_not have_content(bean.name)
        # expect(page).to_not have_content(bean.age)
        expect(page).to_not have_content(bean.breed)
      end
    end
  end
end
