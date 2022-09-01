require 'rails_helper'

RSpec.describe 'application show page' do

  before :each do
    @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @application.pets << @pet_1

  end

  describe 'when i visit an applications show page' do

    describe 'I can see the following: applicant name, address and status' do

      it 'can display application info' do

        visit "/applications/#{@application.id}"

        save_and_open_page

        expect(page).to have_content("Shelby Waters")
        expect(page).to have_content("274 West 11th St, Myers Flatt, NJ, 12447")
        expect(page).to have_content("In Progress")
        expect(page).to have_content("I'm Lonely")
      end
    end

    describe 'I can see the name of the pet the application is for' do

      it 'links to pets show page' do
        visit "/applications/#{@application.id}"

        click_on 'Lucille Bald'
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end


    end
  end



end
