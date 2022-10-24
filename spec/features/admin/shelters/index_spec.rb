require 'rails_helper'

RSpec.describe 'admin shelters index page', type: :feature do
  let!(:garden) {Shelter.create!(name: 'Animal Garden', city: 'Okinawa City', foster_program: false, rank: 7)}
  let!(:mystery) {Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:friends) {Shelter.create!(name: 'Dumb Friends League', city: 'Denver', foster_program: true, rank: 1)}
  let!(:bounce) {Shelter.create!(name: 'Bounce Rescue', city: 'Aurora', foster_program: false, rank: 15)}
  let!(:app) {Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")}
  let!(:kenz) {Application.create!(name: "Kenz L", street_address: "318 E 3rd Ave", city: "Durango", state: "Colorado", zipcode: 81301, description: "Please let me adopt a pet!", status: "Pending")}
  let!(:lauren) {Application.create!(name: "Lauren D", street_address: "55 Mauldeth Drive", city: "Chattanooga", state: "Tennessee", zipcode: 37405, description: "I really need a pet or I will continue to be sad.", status: "Pending")}
  let!(:reba) {friends.pets.create(name: 'Reba', age: 6, breed: 'Jack Russel Terrier mix', adoptable: true)}
  let!(:pimento) {bounce.pets.create(name: 'Pimento', age: 1, breed: 'Corgi', adoptable: true)}

  describe 'the admin shelters index page' do
    it 'lists all the shelters in the system in reverse alphabetical order by name' do
      visit '/admin/shelters'
      
      expect(mystery.name).to appear_before(friends.name)
      expect(friends.name).to appear_before(bounce.name)
      expect(bounce.name).to appear_before(garden.name)
    end
  end

  describe 'there is a section on the index page for (shelters with pending applications)' do
    it 'has the name of every shelter that has a pending application' do
      kenz.add_pet(reba.id)
      lauren.add_pet(pimento.id)

      visit '/admin/shelters'

      expect(page).to have_content(friends.name, count: 2)
      expect(page).to have_content(bounce.name, count: 2)
      expect(page).to have_content(mystery.name, count: 1)
      expect(page).to have_content(garden.name, count: 1)
    end
  end
end