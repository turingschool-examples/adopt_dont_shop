require 'rails_helper'

RSpec.describe Pet, type: :model do
  before :each do
    @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "In Progress" )

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
    end
  end
end