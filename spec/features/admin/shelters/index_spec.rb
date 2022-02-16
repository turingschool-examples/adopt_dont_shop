require 'rails_helper'

RSpec.describe 'The Admin Shelters Index' do 

    before :each do 
        PetApplication.destroy_all
        Shelter.destroy_all
        Application.destroy_all
        Pet.destroy_all
        @dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
        @smart_friends_league = Shelter.create!(foster_program: true, name: "Smart Friends League", city: "Lakewood", rank: "2")
        @any_friends_league = Shelter.create!(foster_program: true, name: "Any Friends League", city: "Littleton", rank: "3")

        @application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", status: "Pending")
        @application_2 = Application.create!(name: "Roman Reigns", street_address: "2354 Narwal ct", city: "Littleton", state: "CO", zipcode: "23785", status: "Pending")
        @application_3 = Application.create!(name: "Doman Dens", street_address: "2354 Bart ct", city: "Middleton", state: "CO", zipcode: "23785", status: "In Progress")

        @mushu = @application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: @dumb_friends_league)
        @mantis = @application_1.pets.create!(adoptable: true, age: "2", breed: "cat", name:"Mantis", shelter: @dumb_friends_league)
        @tesla = @application_3.pets.create!(adoptable: true, age: "9", breed: "cat", name:"Tesla", shelter: @smart_friends_league)
        @bowie = @application_2.pets.create!(adoptable: true, age: "9", breed: "dog", name:"Bowie", shelter: @any_friends_league)
        
    end

    it 'displays all shelters in the system in reverse alphabetical order' do 
        visit '/admin/shelters/'
        within(".all_shelters") do
            expect(page).to have_content(@dumb_friends_league.name)
            expect(page).to have_content(@smart_friends_league.name)
            expect(@smart_friends_league.name).to appear_before(@dumb_friends_league.name)
        end
    end 

    it 'displays all shelters with pending applications in alphabetical order' do 
        visit '/admin/shelters/'
        expect(page).to have_content "Shelters With Pending Applications"
        within(".pending_applications") do 
            expect(page).to have_content("#{@dumb_friends_league.name}")
            expect(page).to have_content("#{@any_friends_league.name}") 
            expect(page).to have_no_content("#{@smart_friends_league.name}") 
            expect(@any_friends_league.name).to appear_before(@dumb_friends_league.name)
        end 
    end 

    it "displays every shelter's name as a link that brings the user to that shelter's admin show page" do 
        visit '/admin/shelters/'
        within(".all_shelters") do
            expect(page).to have_link(@any_friends_league.name)
            expect(page).to have_link(@dumb_friends_league.name)
            expect(page).to have_link(@smart_friends_league.name)
            click_link(@any_friends_league.name)
            expect(current_path).to eq("/admin/shelters/#{@any_friends_league.id}")
        end
        visit '/admin/shelters/'
        within(".pending_applications") do
            expect(page).to have_link(@any_friends_league.name)
            expect(page).to have_link(@dumb_friends_league.name)
            click_link(@dumb_friends_league.name)
            expect(current_path).to eq("/admin/shelters/#{@dumb_friends_league.id}")
        end
    end 
end