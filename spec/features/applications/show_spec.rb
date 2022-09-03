require 'rails_helper'

RSpec.describe 'application show page' do

  before :each do
    @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely", id: 1)
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill', shelter_id: @shelter.id)
    @application.pets << @pet_1


  end

  describe 'when i visit an applications show page' do

    describe 'I can see the following: applicant name, address and status' do

      it 'can display application info' do

        visit "/applications/#{@application.id}"

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

  describe 'can search for and add pets to application' do

    it 'can search for a pet' do
      visit "/applications/#{@application.id}"
      expect(page).to have_content("Add a Pet to this Application")

      expect(page).to_not have_content("Bark Hamill")

      fill_in("Search", with: "Bark")
      click_on 'Submit'

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Bark Hamill")
    end

    it 'can click button to add pet to adoption application' do
      visit "/applications/#{@application.id}"
      fill_in("Search", with: "Bark")
      click_on 'Submit'

      click_on 'Adopt this Pet'

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Bark Hamill")

    end

  end



end
