require 'rails_helper'

RSpec.describe "Application show page", type: :feature do
  describe "As a visitor" do 
    describe "When I visit an application's show page" do 
      it "can see application attributes name, address, description, status" do 
        application = Application.create!(name: "Brian", street_address: "853 West Linden st", city: "Louisville", state: "colorado", zip_code: "80027", description: "I like animals", status: "Accepted")
        shelter = Shelter.create!(foster_program: true, name: "Boulder Humane Society", city: "Boulder", rank: 1)
        jax = application.pets.create!(adoptable: false, age: 4, breed: "ACD", name: "Jax", shelter: shelter)
        rylo = application.pets.create!(adoptable: false, age: 1, breed: "Lab", name: "Rylo", shelter: shelter)
        visit "/applications/#{application.id}"
        
        expect(page).to have_content(application.name)
        expect(page).to have_content(application.street_address)
        expect(page).to have_content(application.city)
        expect(page).to have_content(application.state)
        expect(page).to have_content(application.zip_code)
        expect(page).to have_content(application.description)
        expect(page).to have_content(application.status)

        expect(page).to have_link("#{jax.name}", href: "/pets/#{jax.id}")
        expect(page).to have_link("#{rylo.name}", href: "/pets/#{rylo.id}")

        click_link "#{jax.name}"
        expect(current_path).to eq("/pets/#{jax.id}")

        visit "/applications/#{application.id}"
        click_link "#{rylo.name}"
        expect(current_path).to eq("/pets/#{rylo.id}")
      end
    end
  end
end