require 'rails_helper'

RSpec.describe 'application show page' do

  before :each do
    @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
    @application_2 = Application.create!(name: "Chelsea Marks", street_address: "211 N Clay Ave", city: "Winnebago", state: "MN", zipcode: 55012, status: "In Progress", description: "Idk")
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill', shelter_id: @shelter.id)
    @pet_3 = Pet.create(adoptable: true, age: 13, breed: 'Maine Coon', name: 'Pepper', shelter_id: @shelter.id)
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
      it 'links pet to application show page' do
        visit "/applications/#{@application.id}"

        click_on 'Lucille Bald'
        expect(current_path).to eq("/pets/#{@pet_1.id}")
      end
    end

    describe 'can search for and add pets to application' do
      it 'can search for a pet' do
        visit "/applications/#{@application.id}"

        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Bark Hamill")

        fill_in "Search", with: "Bark Hamill"

        click_on 'Search for Pet'

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Bark Hamill")
      end

      it 'can search for a pet with a partial match' do
        visit "/applications/#{@application.id}"

        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Bark Hamill")

        fill_in "Search", with: "Bark Ham"

        click_on 'Search for Pet'

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Bark Hamill")
      end

      it 'can search for a pet with a a wrong case search' do
        visit "/applications/#{@application.id}"

        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Bark Hamill")

        fill_in "Search", with: "bArK hAmIll"

        click_on 'Search for Pet'

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Bark Hamill")
      end

      it 'can search for a pet with a partial match and wrong case' do
        visit "/applications/#{@application.id}"

        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Bark Hamill")

        fill_in "Search", with: "bAr"

        click_on 'Search for Pet'

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Bark Hamill")
      end

      it 'can click button to add pet to adoption application' do
        visit "/applications/#{@application.id}"

        fill_in "Search", with: "Bark"
        click_on 'Search for Pet'

        within("#pet_#{@pet_2.id}") do
        click_button('Adopt this Pet')
        end

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Bark Hamill")
      end
    end

    describe 'When I have added one or more pets to the application' do
      describe 'I see a section to submit my application' do
        describe 'And in that section I see an input to enter why I would make a good home' do
          it 'updates the description of why applicant would be a good home for pet' do
            visit "/applications/#{@application.id}"

            expect(page).to have_content("I'm Lonely")

            fill_in "Search", with: "Bark"
            click_on 'Search for Pet'

            within("#pet_#{@pet_2.id}") do
              click_on 'Adopt this Pet'
            end

            expect(page).to have_content("Please describe why you would make a good home for this pet")

            fill_in "Please describe why you would make a good home for this pet", with: "I love animals"

            click_on "Submit application"

            expect(current_path).to eq("/applications/#{@application.id}")
          end
        end
      end

      describe 'When I click a button to submit the application' do
        describe 'I am taken back to the applications show page' do
          describe 'And I see an indicator that the application is pending' do
            it 'marks application as pending' do
              visit "/applications/#{@application.id}"

              fill_in 'Search', with: 'Pepper'
              click_on 'Search for Pet'

              within("#pet_#{@pet_3.id}") do
                click_on 'Adopt this Pet'
              end

              fill_in "Please describe why you would make a good home for this pet", with: "I love animals"

              click_on 'Submit application'

              expect(page).to have_content('Status: Pending')
            end
          end

          it 'shows all the pets interested in on the adoption application' do
            visit "/applications/#{@application.id}"

            fill_in 'Search', with: 'Bald'
            click_on 'Search for Pet'

            within("#pet_#{@pet_1.id}") do
              click_on 'Adopt this Pet'
            end

            fill_in 'Search', with: 'Bark'
            click_on 'Search for Pet'

            within("#pet_#{@pet_2.id}") do
              click_on 'Adopt this Pet'
            end

            fill_in "Please describe why you would make a good home for this pet", with: "I love animals"

            click_on 'Submit application'

            expect(page).to have_content('Lucille Bald')
            expect(page).to have_content('Bark Hamill')
          end
        end

        it 'does not show a section to add more pets' do
          visit "/applications/#{@application.id}"

          fill_in 'Search', with: 'Bald'
          click_on 'Search for Pet'

          within("#pet_#{@pet_1.id}") do
            click_on 'Adopt this Pet'
          end

          fill_in "Please describe why you would make a good home for this pet", with: "I love animals"

          click_on 'Submit application'

          expect(page).to_not have_content('Add a Pet to this Application')
        end
      end
    end
  end

  describe 'When I have not added any pets to the application' do
    describe 'I do not see a section to submit my application' do
      it 'Will not allow an application to be submitted without a pet' do
        visit "/applications/#{@application_2.id}"

        expect(page).to_not have_content('Submit application')
      end
    end
  end
end
