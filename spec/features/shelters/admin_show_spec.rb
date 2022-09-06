require 'rails_helper'

RSpec.describe 'Approving/rejecting applications' do
  before :each do
    @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "Pending" )
    @app2 = Application.create!(fname: 'John', lname: 'Smith', street_address: '1234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsable', status: "Pending" )
    @app3 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "Accepted" )
    @app4 = Application.create!(fname: 'John', lname: 'Smith', street_address: '1234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsable', status: "Rejected" )

    @shelter1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

    @pet1 = Pet.create!(adoptable: true, age: 5, breed: 'dog', name: 'Roofus', shelter_id: @shelter1.id)
    @pet2 = Pet.create!(adoptable: true, age: 12, breed: 'cat', name: 'Nacho', shelter_id: @shelter1.id)
    @pet3 = Pet.create!(adoptable: false, age: 8, breed: 'bird', name: 'Big', shelter_id: @shelter1.id)

    @shelter2 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet4 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter2.id)
    @pet5 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter2.id)

    @pet_app1 = PetApplication.create(pet_id: @pet1.id, application_id: @app1.id,  pet_status: "Adoption Rejected")
    @pet_app2 = PetApplication.create(pet_id: @pet2.id, application_id: @app1.id,  pet_status: "Adoption Approved")
  end

  describe 'As an admin' do
    describe 'visit /admin/shelters' do
      it "has a link for the shelters listed" do
        visit '/admin/shelters'

        expect(page).to have_link("Happy Shelter")
      end

      it 'link routes to /admin/shelter/:id' do
        visit '/admin/shelters'

        click_link "Happy Shelter"

        expect(current_path).to eq("/admin/shelters/#{@shelter1.id}")
        expect(page).to have_content("Happy Shelter")
        expect(page).to_not have_content("Aurora Shelter")
      end
    end

    describe 'has statistics section' do
      describe 'that dispalys average age of adoptable pets' do
        it 'has a statistics section' do
          visit "/admin/shelters/#{@shelter1.id}"

          expect(page).to have_content("Shelter Statistics")
        end

        it 'displays average age of adopable pet in section' do
          visit "/admin/shelters/#{@shelter1.id}"

          expect(page).to have_content("Average Age of Adoptable Pets: 8.5")
        end

        it 'displays count of adoptable pets' do
          visit "/admin/shelters/#{@shelter1.id}"

          expect(page).to have_content("Number of Adoptable Pets: 2")
        end

        it 'displays tht count of the number of pets adopted from a shelter' do
          visit "/admin/shelters/#{@shelter1.id}"

          expect(page).to have_content("Number of Pets Adopted: 1")
        end
      end
    end

    describe 'has an Action Required section' do
      describe 'see a list of pets that are in the shelter' do
        it 'that have a pending application and havent been marked approved/rejected' do
          @app3 = Application.create!(fname: 'ohn', lname: 'mith', street_address: '234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsae', status: "Pending" )
          @app4 = Application.create!(fname: 'hn', lname: 'ith', street_address: '34 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsa', status: "Pending" )
          @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
          @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
          @pet_4 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
          @pet_5 = @shelter_3.pets.create(name: 'Banann', breed: 'doll', age: 7, adoptable: true)
          @app3.pets << @pet_4
          @app4.pets << @pet_5
          @app2.pets << @pet2
          @app3.pets << @pet2

          visit "/admin/shelters/#{@shelter1.id}"
          # save_and_open_page
          expect(page).to have_content("Action Required")

          within "#actionrequired" do
            expect(page).to have_content("#{@pet1.name} on app #{@app1.id}")
            expect(page).to have_content("#{@pet2.name} on app #{@app1.id}")
            expect(page).to have_content("#{@pet2.name} on app #{@app2.id}")
            expect(page).to have_content("#{@pet2.name} on app #{@app3.id}")
          end
        end

        it 'has a link for each pending pet that goes to its application page' do
          @app3 = Application.create!(fname: 'ohn', lname: 'mith', street_address: '234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsae', status: "Pending" )
          @app4 = Application.create!(fname: 'hn', lname: 'ith', street_address: '34 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsa', status: "Pending" )
          @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
          @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
          @pet_4 = @shelter_2.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
          @pet_5 = @shelter_3.pets.create(name: 'Banann', breed: 'doll', age: 7, adoptable: true)
          @app3.pets << @pet_4
          @app4.pets << @pet_5
          @app2.pets << @pet2
          @app3.pets << @pet2

          visit "/admin/shelters/#{@shelter1.id}"
          within "#actionrequired" do
            click_link("#{@pet1.name} on app #{@app1.id}")
          end
          expect(current_path).to eq("/admin/applications/#{@app1.id}")

          visit "/admin/shelters/#{@shelter1.id}"
          within "#actionrequired" do
            click_link("#{@pet2.name} on app #{@app1.id}")
          end
          expect(current_path).to eq("/admin/applications/#{@app1.id}")

          visit "/admin/shelters/#{@shelter1.id}"
          within "#actionrequired" do
            click_link("#{@pet2.name} on app #{@app2.id}")
          end
          expect(current_path).to eq("/admin/applications/#{@app2.id}")
        end
      end
    end
  end
end