require 'rails_helper'
RSpec.describe 'application creation' do
  # before :each do
  #   @shelter_1 = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  #   @shelter_2 = Shelter.create(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
  #   @shelter_3 = Shelter.create(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
  #   @shelter_4 = Shelter.create(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)
  #
  #   @scooby = @shelter_1.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
  #   @daisy = @shelter_1.pets.create(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true)
  #   @artimus = @shelter_2.pets.create(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true)
  #   @apollo = @shelter_2.pets.create(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true)
  #   @scruffy = @shelter_3.pets.create(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true)
  #   @pineapple = @shelter_3.pets.create(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true)
  #   @mango = @shelter_4.pets.create(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true)
  #   @onion = @shelter_4.pets.create(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true)
  #   @peach = @shelter_4.pets.create(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true)
  #
  #   @a_1= Application.create(first_name: 'Lemon', last_name: 'Tiger', street_address: '1225 Alvaro Obgeron Dr.', city: 'Mexico City, GA', post_code: '67518', good_owner: 'Give the best cuddles!')
  #   @a_2= Application.create(first_name: 'Salty', last_name: 'Hippo', street_address: '367 CBTIS Overton St.', city: 'Colima, DC', post_code: '14628', good_owner: 'Give the best treats!')
  #   @a_3= Application.create(first_name: 'Funky', last_name: 'Platypus', street_address: '15 Overpath Pkwy.', city: 'Shenzhen, OH', post_code: '97627', good_owner: 'Give the best walks!')
  #
  # end

  describe 'new application' do
    it 'renders the new app form' do
      visit '/pets'

      expect(page).to have_link('Start an Application')
      click_link('Start an Application')
      expect(page).to have_current_path('/applications/new')

      expect(find('form')).to have_content("First name")
      expect(find('form')).to have_content('Last name')
      expect(find('form')).to have_content('Street address')
      expect(find('form')).to have_content('City')
      expect(find('form')).to have_content('Post code')
      expect(find('form')).to have_content('What makes me a good pet owner')
    end
  end


  describe 'new application' do
    it 'creates the application' do
      visit '/applications/new'

      fill_in 'First name', with: 'Sammy'
      fill_in 'Last name', with: 'Smith'
      fill_in 'Street address', with: '367 CBTIS Overton St.'
      fill_in 'City', with: 'Washington DC'
      fill_in 'Post code', with: 12647
      fill_in 'What makes me a good pet owner', with: 'Long walks on the beach'

      click_button 'Submit Application'
      sammy = Application.last

      expect(page).to have_current_path("/applications/#{sammy.id}")
      expect(page).to have_content('Sammy')

    end
  end

end
