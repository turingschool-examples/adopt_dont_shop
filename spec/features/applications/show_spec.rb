require 'rails_helper'

RSpec.describe 'applications show' do
  describe 'without pets' do
    before :each do
      @app = Application.create!(
        name: 'Tanner',
        address: '12345 Street St',
        city: 'Austin',
        state: 'Texas',
        zipcode: '12345'
      )
       visit application_path(@app.id)
    end

    it 'has the application info' do
      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
      expect(page).to have_content('In Progress')
    end
  end

  describe 'pet searching and adding' do
    before :each do
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
      @app = Application.create!(
        name: 'Tanner',
        address: '12345 Street St',
        city: 'Austin',
        state: 'Texas',
        zipcode: '12345'
      )
       visit application_path(@app.id)
    end

    it 'can show matching pets' do
      fill_in 'Name', with: 'claw'
      click_on 'Find'

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.breed)
      expect(page).to have_content(@pet_2.age)
    end
  end
end
