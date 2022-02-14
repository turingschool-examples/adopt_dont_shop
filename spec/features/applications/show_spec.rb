require 'rails_helper'

RSpec.describe 'the application show' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
      @shelter_3 = Shelter.create(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
      @shelter_4 = Shelter.create(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)

      @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
      @daisy = Pet.create!(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
      @artimus = Pet.create!(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true, shelter_id: @shelter_2.id)
      @apollo = Pet.create!(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true, shelter_id: @shelter_2.id)
      @scruffy = Pet.create!(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true, shelter_id: @shelter_3.id)
      @pineapple = Pet.create!(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true, shelter_id: @shelter_3.id)
      @mango = Pet.create!(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true, shelter_id: @shelter_4.id)
      @onion = Pet.create!(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true, shelter_id: @shelter_4.id)
      @peach = Pet.create!(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true, shelter_id: @shelter_4.id)


      @app_1= Application.create(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518', status: "In Progress")
      @app_2= Application.create(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628', status: "In Progress")
      @app_3= Application.create(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627', status: "In Progress")

    end

      it "shows the all of the applicants and their details" do

      ApplicationPet.create!(pet_id:@scooby.id, application_id: @app_1.id)
      ApplicationPet.create!(pet_id:@mango.id, application_id: @app_1.id)

      visit "/applications/#{@app_1.id}"

      expect(page).to have_content(@app_1.first_name)
      expect(page).to have_content(@app_1.last_name)
      expect(page).to have_content(@app_1.street_address)
      expect(page).to have_content(@app_1.city)
      expect(page).to have_content(@app_1.post_code)
      expect(page).to have_content(@app_1.status)
      expect(page).to have_content(@scooby.name)
      expect(page).to have_content(@mango.name)

      expect(page).not_to have_content(@app_2.first_name)
      expect(page).not_to have_content(@app_3.first_name)

      click_link 'Scooby'

      expect(page).to have_current_path("/pets/#{@scooby.id}")
      expect(page).to have_content(@scooby.name)

    end

    it 'displays a link to search for pets from app #show' do

      visit "/applications/#{@app_2.id}"


      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_content('Search by pet name')

      fill_in 'Search', with: "Onion"
      click_on("Search")

      expect('Pet search results').to appear_before(@onion.name)
    end

    it 'add pet to application' do

      visit "/applications/#{@app_3.id}"


      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_content('Search by pet name')

      fill_in 'Search', with: "Apollo"
      click_on("Search")
      expect('Pet search results').to appear_before(@apollo.name)

      click_on "Adopt #{@apollo.name}"


      expect('Pets added to my application:').to appear_before(@apollo.name)
    end

    it "can submit an application" do

    ApplicationPet.create!(pet_id:@scooby.id, application_id: @app_1.id)
    ApplicationPet.create!(pet_id:@mango.id, application_id: @app_1.id)

    visit "/applications/#{@app_1.id}"

    expect('Pets added to my application:').to appear_before(@scooby.name)
    expect('Pets added to my application:').to appear_before(@mango.name)

    expect(page).to have_content('Why would you make an excellent owner for these pets?')

    fill_in 'Please describe', with: "Long walks on the beach"
    click_on("Submit my application")
  end
end
