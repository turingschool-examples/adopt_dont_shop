require "rails_helper"

RSpec.describe "Applications" do
  describe "when I visit /applications/:id" do
    describe "User story 1 / As a user " do
      it " I see the applicant name, full adress, description, name of all pet( pet name is link to show page), application status" do
        shelter = Shelter.create!(name: 'Petz R Us', city: 'Denver', foster_program: true, rank: 10)
        max = shelter.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
        app_1 = Application.create!(name: "Joe", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "This is a description", status: "In Progress")
        ApplicationPet.create!(application: app_1, pet: max)
        visit "/applications/#{app_1.id}"
        
        expect(page).to have_content("Applicant Name: #{app_1.name}")
        expect(page).to have_content("Address: #{app_1.street_address}, #{app_1.city}, #{app_1.state}, #{app_1.zip}")
        expect(page).to have_content("Description: #{app_1.description}")
        expect(page).to have_content("Pet Name: #{app_1.pets.first.name}")
        expect(page).to have_content("Status: #{app_1.status}")
      end

      it " I see pet name that are links to their show page" do 
        shelter = Shelter.create!(name: 'Petz R Us', city: 'Denver', foster_program: true, rank: 10)
        max = shelter.pets.create!(name: 'Max', breed: 'goldendoodle', age: 2, adoptable: true)
        app_1 = Application.create!(name: "Joe", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "This is a description", status: "In Progress")
        ApplicationPet.create!(application: app_1, pet: max)
        visit "/applications/#{app_1.id}"

        expect(page).to have_link("#{app_1.pets.first.name}", href: "/pets/#{max.id}")
        click_link("#{max.name}")
        expect(current_path).to eq("/pets/#{max.id}")
      end
    end
  end 
end