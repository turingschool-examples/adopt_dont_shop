require 'rails_helper'

RSpec.describe 'The admin applications show page' do 
    before :each  do 
        @dumb_friends_league = Shelter.create!(foster_program: true, name: "Dumb Friends League", city: "Englewood", rank: "1")
        @smart_friends_league = Shelter.create!(foster_program: true, name: "Smart Friends League", city: "Lakewood", rank: "2")

        @application_1 = Application.create!(name: "Sedan Turtle", street_address: "3425 Gransfield ave", city: "Denver", state: "CO", zipcode: "80219", status: "Pending")
        @application_2 = Application.create!(name: "Roman Reigns", street_address: "2354 Narwal ct", city: "Littleton", state: "CO", zipcode: "23785", status: "Pending")
        @application_3 = Application.create!(name: "Doman Dens", street_address: "2354 Bart ct", city: "Middleton", state: "CO", zipcode: "23785", status: "In Progress")

        @mushu = @application_1.pets.create!(adoptable: true, age: "5", breed: "dog", name:"Mushu", shelter: @dumb_friends_league)
        @mantis = @application_1.pets.create!(adoptable: true, age: "2", breed: "cat", name:"Mantis", shelter: @dumb_friends_league)
        @tesla = @application_3.pets.create!(adoptable: true, age: "9", breed: "cat", name:"Tesla", shelter: @smart_friends_league)
    end
    
    it 'shows the admin user one appliciation and all of the pets on that application' do 
        visit "/admin/applications/#{@application_1.id}"
        expect(page).to have_content(@application_1.description)
        expect(page).to have_content(@application_1.status)
        expect(page).to have_content(@mushu.name)
        expect(page).to have_content(@mantis.name)
    end 

    it 'has a button next to each pet on an application that allows the admin user to approve that specific pet' do 
        visit "/admin/applications/#{@application_1.id}"
        click_button("Approve #{@mushu.name}")
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to have_content("#{@mushu.name} has been approved")
    end 
end 