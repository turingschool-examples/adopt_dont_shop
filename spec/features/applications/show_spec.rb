require 'rails_helper'

RSpec.describe 'the application show' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create(name: 'Happy Building', city: 'Stone Mtn GA', foster_program: true, rank: 1)
      @shelter_3 = Shelter.create(name: 'Sad Building', city: 'Baltimore MD', foster_program: true, rank: 3)
      @shelter_4 = Shelter.create(name: 'Meh Building', city: 'Brooklyn NY', foster_program: false, rank: 5)

      @scooby = @shelter_1.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
      @daisy = @shelter_1.pets.create(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true)
      @artimus = @shelter_2.pets.create(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true)
      @apollo = @shelter_2.pets.create(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true)
      @scruffy = @shelter_3.pets.create(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true)
      @mangie = @shelter_3.pets.create(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true)
      @mangie = @shelter_4.pets.create(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true)
      @mangie = @shelter_4.pets.create(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true)
      @mangie = @shelter_4.pets.create(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true)

      @lemon= Application.create(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518', good_owner: 'Give the best cuddles!')
      @salty= Application.create(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628', good_owner: 'Give the best treats!')
      @funky= Application.create(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627', good_owner: 'Give the best walks!')
    end

    it "shows the all of the applicants and their details" do
      # require "pry"; binding.pry
    visit "/applications/#{@salty.id}"

    expect(page).to have_content(@salty.first_name)
    expect(page).to have_content(@salty.last_name)
    expect(page).to have_content(@salty.street_address)
    expect(page).to have_content(@salty.city)
    expect(page).to have_content(@salty.post_code)
    expect(page).to have_content(@salty.good_owner)
    expect(page).to have_content(@salty.pet_matches)
    expect(page).to have_content(@salty.application_status)

    expect(page).not_to have_content(@lemon.first_name)
    expect(page).not_to have_content(@funky.first_name)

  end

    it "shows the all of the applicants and their details" do
    visit "/applications/#{@funky.id}"

    expect(page).to have_content(@funky.first_name)
    expect(page).to have_content(@funky.last_name)
    expect(page).to have_content(@funky.street_address)
    expect(page).to have_content(@funky.city)
    expect(page).to have_content(@funky.post_code)
    expect(page).to have_content(@funky.good_owner)
    expect(page).to have_content(@funky.pet_matches)
    expect(page).to have_content(@funky.application_status)

    expect(page).not_to have_content(@lemon.first_name)
    expect(page).not_to have_content(@salty.first_name)
  end

    it "shows the all of the applicants and their details" do
    visit "/applications/#{@lemon.id}"

    expect(page).to have_content(@lemon.first_name)
    expect(page).to have_content(@lemon.last_name)
    expect(page).to have_content(@lemon.street_address)
    expect(page).to have_content(@lemon.city)
    expect(page).to have_content(@lemon.post_code)
    expect(page).to have_content(@lemon.good_owner)
    expect(page).to have_content(@lemon.pet_matches)
    expect(page).to have_content(@lemon.application_status)

    expect(page).not_to have_content(@funky.first_name)
    expect(page).not_to have_content(@salty.first_name)
  end

end
