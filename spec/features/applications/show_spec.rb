require 'rails_helper'

RSpec.describe 'application show page' do
    before :each do 
        @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        @scooby = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
        @clifford = Pet.create(name: 'Clifford', age: 5, breed: 'Big Red Dog', adoptable: true, shelter_id: @shelter.id)

        @john_doe_app = Application.create!(name: 'John Doe', street_address: '656 Main St.', city: 'Birmingham', 
                        state: 'AL', zip_code: 85267, description: "I've been a dog trainer for 40 years and I spend most of my days at home.", 
                        status: 'In Progress')
        @john_doe_app.pets << @scooby
    end

    it "shows the application and all it's attributes" do
        visit "/applications/#{@john_doe_app.id}"
        expect(page).to have_content(@john_doe_app.name)
        expect(page).to have_content(@john_doe_app.street_address)
        expect(page).to have_content(@john_doe_app.description)
        expect(page).to have_content(@scooby.name)
        # save_and_open_page

        click_link("#{@scooby.name}")
        expect(current_path).to eq("/pets/#{@scooby.id}")
    end

    it "Can search pets to unfinished application" do
        visit "/applications/#{@john_doe_app.id}"
        expect(page).to have_content("Add a Pet to this Application")
        fill_in("search", with: @clifford.name)
        click_button("Search")
        expect(page).to have_content(@clifford.name)
    end

    it "Can add pets to unfinished application" do
        visit "/applications/#{@john_doe_app.id}"
        fill_in("search", with: @clifford.name)
        click_button("Search")
        expect(page).to have_content(@clifford.name)
        click_button("Adopt this Pet")
        expect(@john_doe_app.pets).to include(@clifford)
    end
end