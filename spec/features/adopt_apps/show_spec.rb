require "rails_helper"

RSpec.describe "the AdoptApps show page" do 
  describe "as a visitor" do 
    describe "when I visit the Request show page" do 
      before(:each) do 
        @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
        @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
        @pet_3 = Pet.create(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter.id)
        @app = AdoptApp.create!(name: "Amanda Ross", 
                                 street_address: "3220 N Williams St.", 
                                 city: "Denver", 
                                 state: "CO", 
                                 zip_code: "80205", 
                                 description: "I want a best friend.",
                                 status: "In Progress"
                               )
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_1)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_2)
        AdoptAppPet.create!(adopt_app: @app, pet: @pet_3)
      end

      it "displays the application attributes" do  
        visit "/adopt_apps/#{@app.id}"

        expect(page).to have_content("Name: Amanda Ross")
        expect(page).to have_content("Address: 3220 N Williams St. Denver, CO 80205")
        expect(page).to have_content("Description: I want a best friend.")
        expect(page).to have_link("Bare-y Manilow", href: "/pets/#{@pet_1.id}")
        expect(page).to have_link("Lobster", href: "/pets/#{@pet_2.id}")
        expect(page).to have_link("Sylvester", href: "/pets/#{@pet_3.id}")
        expect(page).to have_content("Status: In Progress")
      end
    end
  end

end