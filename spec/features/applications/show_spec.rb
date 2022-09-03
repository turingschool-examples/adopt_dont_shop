require 'rails_helper'

RSpec.describe 'application show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @pet1 = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @pet2 = @shelter.pets.create!(name: "Floofy", adoptable: true, age: 7, breed: "mixed breed")
      @pet3 = @shelter.pets.create!(name: "Butters", adoptable: true, age: 6, breed: "lab")
      @pet4 = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 10, breed: "pomeranian")
      @pet5 = @shelter.pets.create!(name: "Mr. FLUFF", adoptable: true, age: 4, breed: "cockerspaniel")


      @application1 = Application.create!(first_name: "Samantha", last_name: "Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
      @application2 = Application.create!(first_name: "Peter", last_name: "Pinckens", street_address: "123 Pineapple Street", city: "Denver", state: "CO", zip_code: 72641, description: "I would really like an animal to keep me company", status: "In Progress")
    end
    
    it 'I can see all attributes of the application' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content('Samantha')
      expect(page).to have_content('Smith')
      expect(page).to have_content('123 Mulberry Street')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('20202')
      expect(page).to have_content('In Progress')
    end

    it 'I has a search bar where you can search for pets' do
      visit "/applications/#{@application1.id}"
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_content('Search for pet by name:')
    end

    it 'I can fill in the search bar & then see all pets whose names match' do
      visit "/applications/#{@application1.id}"

      fill_in('Search for pet by name:', with: 'Fluff')
      click_on('Search for Pet')

      expect(page).to have_content('Fluffy')
      expect(page).to have_content('Mr. FLUFF')
    end

    it 'I can see a button to "Adopt this Pet" ' do
      visit "/applications/#{@application1.id}"

      fill_in('Search for pet by name:', with: 'Fluffy')
      click_on('Search for Pet')

        within("#pet_#{@pet1.id}") do
        expect(page).to have_button("Adopt this Pet")
      end

      within("#pet_#{@pet4.id}") do
        expect(page).to have_button("Adopt this Pet")
      end
    end

    it 'I can click the adopt pet button & Im taken to the app/show page where I see the pet I want to adopt listed on the application ' do

      visit "/applications/#{@application1.id}"

      fill_in('Search for pet by name:', with: 'Fluffy')
      click_on('Search for Pet')

      within("#pet_#{@pet1.id}") do
        click_button('Adopt this Pet')
      end

      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content("Fluffy")
    end

    it "I can add more than one pet to the application" do
      visit "/applications/#{@application1.id}"

      fill_in('Search for pet by name:', with: 'Fluffy')
      click_on('Search for Pet')

      within("#pet_#{@pet1.id}") do
        click_button('Adopt this Pet')
      end

      fill_in('Search for pet by name:', with: 'Butters')
      click_on('Search for Pet')
      within("#pet_#{@pet3.id}") do
        click_button('Adopt this Pet')
      end

      expect(page).to have_content("Fluffy")
      expect(page).to have_content("Butters")
    end


      describe "After I add a pet & before I click submit " do

        it "I can see a section to submit my application" do
          visit "/applications/#{@application1.id}"

          fill_in('Search for pet by name:', with: 'Fluffy')
          click_on('Search for Pet')

          within("#pet_#{@pet1.id}") do
            click_button('Adopt this Pet')
          end

          fill_in('Search for pet by name:', with: 'Butters')
          click_on('Search for Pet')
          within("#pet_#{@pet3.id}") do
            click_button('Adopt this Pet')
          end

          expect(page).to have_button("Submit My Application")
        end

        it "I can see a description box to tell why I'd be a good owner" do
          visit "/applications/#{@application1.id}"

          fill_in('Search for pet by name:', with: 'Fluffy')
          click_on('Search for Pet')

          within("#pet_#{@pet1.id}") do
            click_button('Adopt this Pet')
          end
          fill_in('Search for pet by name:', with: 'Butters')
          click_on('Search for Pet')
          within("#pet_#{@pet3.id}") do
            click_button('Adopt this Pet')
          end

          expect(page).to have_content("Please describe why you would like to adopt these pets.")
        end
      end

      describe "After I click submit for my application" do
        it "When I fill this in I am taken back to the app show page" do
          visit "/applications/#{@application1.id}"

          fill_in('Search for pet by name:', with: 'Fluffy')
          click_on('Search for Pet')

            within("#pet_#{@pet1.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Search for pet by name:', with: 'Butters')
          click_on('Search for Pet')
            within("#pet_#{@pet3.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Please describe why you would like to adopt these pets.', with: 'I think I would make a great pet owner.')
          click_on('Submit My Application')

          expect(current_path).to eq("/applications/#{@application1.id}")
        end

        it "And on that page I see Pending" do
          visit "/applications/#{@application1.id}"

          fill_in('Search for pet by name:', with: 'Fluffy')
          click_on('Search for Pet')

            within("#pet_#{@pet1.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Search for pet by name:', with: 'Butters')
          click_on('Search for Pet')
            within("#pet_#{@pet3.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Please describe why you would like to adopt these pets.', with: 'I think I would make a great pet owner.')
          click_on('Submit My Application')

          expect(page).to have_content("Pending")
        end

        it "I see all the pets that I want to adopt" do
          visit "/applications/#{@application1.id}"

          fill_in('Search for pet by name:', with: 'Fluffy')
          click_on('Search for Pet')

            within("#pet_#{@pet1.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Search for pet by name:', with: 'Butters')
          click_on('Search for Pet')
            within("#pet_#{@pet3.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Please describe why you would like to adopt these pets.', with: 'I think I would make a great pet owner.')
          click_on('Submit My Application')

          expect(page).to have_content("Fluffy")
          expect(page).to have_content("Butters")
        end

        it "I do not see a section to add more pets to this application" do
          visit "/applications/#{@application1.id}"

          fill_in('Search for pet by name:', with: 'Fluffy')
          click_on('Search for Pet')

            within("#pet_#{@pet1.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Search for pet by name:', with: 'Butters')
          click_on('Search for Pet')
            within("#pet_#{@pet3.id}") do
            click_button('Adopt this Pet')
            end

          fill_in('Please describe why you would like to adopt these pets.', with: 'I think I would make a great pet owner.')
          click_on('Submit My Application')

          expect(page).to_not have_button("Search for Pet")
        end
      end


      it "I do not see a button submit my application until I have selected pets" do
        visit "/applications/#{@application1.id}"

        expect(page).to_not have_button("Submit My Application")

        fill_in('Search for pet by name:', with: 'Fluffy')
        click_on('Search for Pet')
        within("#pet_#{@pet1.id}") do
        click_button('Adopt this Pet')
          end

        expect(page).to have_button("Submit My Application")
      end

      it "I do not see a description to fill out until I have selected pets" do
        visit "/applications/#{@application1.id}"

        expect(page).to_not have_content("Please describe why you would like to adopt these pets.")
        fill_in('Search for pet by name:', with: 'Fluffy')
        click_on('Search for Pet')

        within("#pet_#{@pet1.id}") do
        click_button('Adopt this Pet')
        end


        expect(page).to have_content("Please describe why you would like to adopt these pets.")
      end
    end
end
