require 'rails_helper'

RSpec.describe 'admin show page' do
    before :each do
        @shelter = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE")

        @pet_1 = @shelter.pets.create!(name: "King Trash Mouth", age: 14)
        @pet_2 = @shelter.pets.create!(name: "Princess Dumptruck", age: 18)
        @pet_3 = @shelter.pets.create!(name: "Eggs Sinclair", age: 10)
        @pet_4 = @shelter.pets.create!(name: "Monster Truck Wendy", age: 5)

        @pets = [@pet_1, @pet_2, @pet_3, @pet_4]

        @app = @shelter.apps.create!(
        name: "Gob Beldof", 
        address: "152 Animal Ave.", 
        city: "Omaha, NE", 
        zip_code: "19593",
        status: "In Progress"
        )

        @app.pets << @pet_1
        @app.pets << @pet_2
        @app.pets << @pet_3
        @app.pets << @pet_4

        visit "/admin/apps/#{@app.id}"
    end

    it 'has a button to approve each pet' do
        # When I click that button
        @app.pets.each do |pet|
            within("#pet_#{pet.id}") do
                expect(page).to have_button("Approve #{pet.name}")
            end
        end 
    end

    it 'approves a pet for the application' do
        click_button "Approve #{@pet_1.name}"
        expect(current_path).to eq "/admin/apps/#{@app.id}"
        within("#pet_#{@pet_1.id}") do
            expect(page).to_not have_button("Approve #{@pet_1.name}")
            expect(page).to have_content("Approved")
        end
        # Then I'm taken back to the admin application show page
        # And next to the pet that I approved, I do not see a button to approve this pet
        # And instead I see an indicator next to the pet that they have been approved
    end

    it 'when all pets are approved' do
        click_button "Approve #{@pet_1.name}"
        click_button "Approve #{@pet_2.name}"
        click_button "Approve #{@pet_3.name}"
        click_button "Approve #{@pet_4.name}"

        expect(current_path).to eq "/admin/apps/#{@app.id}"
        within("#app_status") do
            expect(page).to have_content("approved")
        end
    end

    xit 'when one or more pets are rejected' do

    end
end