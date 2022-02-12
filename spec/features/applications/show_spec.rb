require 'rails_helper'

RSpec.describe 'the application show' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
      @shelter_3 = Shelter.create(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
      @shelter_4 = Shelter.create(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)

      @scooby = @shelter_1.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
      @daisy = @shelter_1.pets.create(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true)
      @artimus = @shelter_2.pets.create(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true)
      @apollo = @shelter_2.pets.create(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true)
      @scruffy = @shelter_3.pets.create(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true)
      @pineapple = @shelter_3.pets.create(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true)
      @mango = @shelter_4.pets.create(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true)
      @onion = @shelter_4.pets.create(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true)
      @peach = @shelter_4.pets.create(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true)

      @a_1= Application.create(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518', good_owner: 'Give the best cuddles!')
      @a_2= Application.create(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628', good_owner: 'Give the best treats!')
      @a_3= Application.create(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627', good_owner: 'Give the best walks!')

      ApplicationPet.create!(pet_id:@scooby.id, application_id: @a_1.id)
      ApplicationPet.create!(pet_id:@mangie.id, application_id: @a_1.id)
    end

      it "shows the all of the applicants and their details" do
      visit "/applications/#{@a_1.id}"

      expect(page).to have_content(@a_1.first_name)
      expect(page).to have_content(@a_1.last_name)
      expect(page).to have_content(@a_1.street_address)
      expect(page).to have_content(@a_1.city)
      expect(page).to have_content(@a_1.post_code)
      expect(page).to have_content(@a_1.good_owner)
      expect(page).to have_content(@a_1.status)
      expect(page).to have_content(@scooby.name)
      expect(page).to have_content(@mangie.name)

      expect(page).not_to have_content(@a_2.first_name)
      expect(page).not_to have_content(@a_3.first_name)

      click_link 'Scooby'
      expect(page).to have_current_path("/pets/#{@scooby.id}")
      expect(page).to have_content(@scooby.name)

    end
end
