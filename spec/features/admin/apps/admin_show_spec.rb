require 'rails_helper'

RSpec.describe 'admin show page' do
    before :each do
        @shelter = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha, NE")

        @pet_1 = @shelter.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
        @pet_2 = @shelter.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
        @pet_3 = @shelter.pets.create!(adoptable: true, name: "Eggs Sinclair", age: 10, breed: "Tres Marias")
        @pet_4 = @shelter.pets.create!(adoptable: true, name: "Monster Truck Wendy", age: 5, breed: "Vancouver Island")

        @app = @shelter.apps.create!(
        name: "Gob Beldof", 
        address: "152 Animal Ave.", 
        city: "Omaha, NE", 
        zip_code: "19593",
        status: "In Progress")

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

    it 'has a button to reject each pet' do
        # When I click that button
        @app.pets.each do |pet|
            within("#pet_#{pet.id}") do
                expect(page).to have_button("Reject #{pet.name}")
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
    end
    describe 'for an app with multiple pets, approving 1 pet' do
        it 'does not change that pets status on other apps' do
            app_2 = @shelter.apps.create!(
                name: "Tarzo the Impaler", 
                address: "154 Animal Ave.", 
                city: "Omaha, NE", 
                zip_code: "19593",
                status: "In Progress")
            app_2.pets << @pet_1

            click_button "Approve #{@pet_1.name}"
            expect(current_path).to eq "/admin/apps/#{@app.id}"
            within("#pet_#{@pet_1.id}") do
                expect(page).to_not have_button("Approve #{@pet_1.name}")
                expect(page).to have_content("Approved")
            end
            visit "/admin/apps/#{app_2.id}"
            within("#pet_#{@pet_1.id}") do
                expect(page).to have_button("Approve #{@pet_1.name}")
            end
        end
    end

    it 'when all pets are approved' do
        click_button "Approve #{@pet_1.name}"
        click_button "Approve #{@pet_2.name}"
        click_button "Approve #{@pet_3.name}"
        click_button "Approve #{@pet_4.name}"

        expect(current_path).to eq "/admin/apps/#{@app.id}"
        within("#app_status") do
            expect(page).to have_content("Approved")
        end
    end

    it 'when all pets are rejected' do
        click_button "Reject #{@pet_1.name}"
        click_button "Reject #{@pet_2.name}"
        click_button "Reject #{@pet_3.name}"
        click_button "Reject #{@pet_4.name}"

        expect(current_path).to eq "/admin/apps/#{@app.id}"
        within("#app_status") do
            expect(page).to have_content("Rejected")
        end
    end

    it 'rejects a pet for the application' do
        click_button "Reject #{@pet_1.name}"
        expect(current_path).to eq "/admin/apps/#{@app.id}"
        within("#pet_#{@pet_1.id}") do
            expect(page).to_not have_button("Reject #{@pet_1.name}")
            expect(page).to have_content("Rejected")
        end
    end

    it 'application approval changes pets adoptable status' do
        visit "/pets/#{@pet_1.id}"
        expect(page).to have_content("Adoptable? true")

        visit "/admin/apps/#{@app.id}"
        click_button "Approve #{@pet_1.name}"
        click_button "Approve #{@pet_2.name}"

        visit "/pets/#{@pet_2.id}"
        expect(page).to have_content("Adoptable? true")

        visit "/admin/apps/#{@app.id}"
        click_button "Approve #{@pet_3.name}"
        click_button "Approve #{@pet_4.name}"

        visit "/pets/#{@pet_1.id}"
        expect(page).to have_content("Adoptable? false")
        visit "/pets/#{@pet_3.id}"
        expect(page).to have_content("Adoptable? false")
    end

    it 'pets on approved app no longer available on a pending app' do
        app_2 = @shelter.apps.create!(
            name: "Tarzo the Impaler", 
            address: "154 Animal Ave.", 
            city: "Omaha, NE", 
            zip_code: "19593",
            status: "In Progress")
        app_2.pets << @pet_1

        click_button "Approve #{@pet_1.name}"
        click_button "Approve #{@pet_2.name}"
        click_button "Approve #{@pet_3.name}"
        click_button "Approve #{@pet_4.name}"

        visit "/admin/apps/#{app_2.id}"
        
        within("#pet_#{@pet_1.id}") do
            expect(page).to have_content("#{@pet_1.name} has been adopted!")
            expect(page).to have_button("Reject #{@pet_1.name}")
        end
    end
end