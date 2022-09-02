require 'rails_helper'

RSpec.describe Pet, type: :model do
  before :each do
    @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "Pending" )
    @app2 = Application.create!(fname: 'John', lname: 'Smith', street_address: '1234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsable', status: "In Progress" )
    @shelter1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

    @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed: 'dog', name: 'Roofus')
    @pet2 = @shelter1.pets.create!(adoptable: true, age: 12, breed: 'cat', name: 'Nacho')
    @pet3 = @shelter1.pets.create!(adoptable: false, age: 8, breed: 'bird', name: 'Big')

    @shelter2 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    @pet5 = @shelter2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')

    @app1.pets << @pet1
  end

  describe 'Application show page' do
    describe 'as a visitor' do
      describe 'I can see the following' do
        it 'displays full name of applicant' do

          visit "/applications/#{@app1.id}"

          expect(page).to have_content("#{@app1.fname} #{@app1.lname}")
        end

        it 'displays full address' do
          visit "/applications/#{@app1.id}"

          expect(page).to have_content("#{@app1.street_address}")
          expect(page).to have_content("#{@app1.city}, #{@app1.state} #{@app1.zip_code}")
        end

        it 'displays description of good home arg' do
          visit "/applications/#{@app1.id}"

          expect(page).to have_content("#{@app1.good_home_argument}")
        end

        it 'displays all pet names application is for and is linked' do
          visit "/applications/#{@app1.id}"

          expect(page).to have_content("#{@app1.pets.first.name}")
          expect(page).to_not have_content("#{@pet2.name}")
          expect(page).to have_link("#{@app1.pets.first.name}")

          click_link("#{@app1.pets.first.name}")
          expect(current_path).to eq("/pets/#{@app1.pets.first.id}")
        end

        it 'displays app status' do
          visit "/applications/#{@app1.id}"

          expect(page).to have_content("#{@app1.status}")
        end
      end

      describe 'visit apps show page and app has not been submitted' do
        describe 'I see' do
          it 'a section for adding a pet to the app' do
            visit "/applications/#{@app2.id}"
            expect(page).to have_content("In Progress")

            expect(page).to have_content("Add a Pet to this Application")
          end

          it 'a search for Pets by name with input' do
            visit "/applications/#{@app2.id}"
            
            expect(page).to have_content('Search For Your Future Pet!')
            expect(page).to have_button('Search All Pets')
          end

          it 'a search returns pets with that name on the show page' do
            visit "/applications/#{@app2.id}"
            
            fill_in 'Search For Your Future Pet!', with: 'Nacho'
            click_button 'Search All Pets'

            expect(current_path).to eq("/applications/#{@app2.id}")

            expect(page).to have_content(@pet2.name)
            expect(page).to_not have_content(@pet1.name)
          end

          it 'a search returns pets with that name that partially match search' do
            visit "/applications/#{@app2.id}"
            
            fill_in 'Search For Your Future Pet!', with: 'Na'
            click_button 'Search All Pets'

            expect(current_path).to eq("/applications/#{@app2.id}")

            expect(page).to have_content(@pet2.name)
            expect(page).to_not have_content(@pet1.name)
          end

          it 'a search returns pets with that name that partially match search' do
            visit "/applications/#{@app2.id}"

            fill_in 'Search For Your Future Pet!', with: 'na'
            click_button 'Search All Pets'

            expect(current_path).to eq("/applications/#{@app2.id}")

            expect(page).to have_content(@pet2.name)
            expect(page).to_not have_content(@pet1.name)
          end
        end
      end

      describe 'visit apps show page and app has not been submitted' do
        describe 'when i search for a pet' do
          it 'there is a button to adopt pet next to the name' do
            visit "/applications/#{@app2.id}"

            fill_in 'Search For Your Future Pet!', with: 'na'
            click_button 'Search All Pets'

            within "#application_pet_#{@pet2.id}" do
              expect(page).to have_button("Adopt this Pet")
            end
          end

          it 'Adopt pet button is clicked and returns to show page' do
            visit "/applications/#{@app2.id}"

            fill_in 'Search For Your Future Pet!', with: 'na'
            click_button 'Search All Pets'

            within "#application_pet_#{@pet2.id}" do
              click_button "Adopt this Pet"
            end

            expect(current_path).to eq("/applications/#{@app2.id}")
          end
          
          it 'Adopt pet button is clicked and returns to show page' do
            visit "/applications/#{@app2.id}"

            expect(page).to_not have_content(@pet2.name)

            fill_in 'Search For Your Future Pet!', with: 'na'

            click_button 'Search All Pets'

            within "#application_pet_#{@pet2.id}" do
              click_button "Adopt this Pet"
            end

            expect(page).to have_content(@pet2.name)
          end
        end
      end
    end
  end
end