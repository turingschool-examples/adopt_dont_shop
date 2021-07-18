require 'rails_helper'

RSpec.describe 'Application show page' do
  before (:each) do
    @furry = Shelter.create!(name:'Furrry Shelter', foster_program: true, city: 'New Orleans', rank: 5)

    @bruce = @furry.pets.create!(name: 'Bruce', age: 3, adoptable: true, breed: 'black lab')
    @lana = @furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')
    @doc = @furry.pets.create!(name: 'Doc', age: 8, adoptable: true, breed: 'schnauzer')

    @application1 = Application.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I love my furry friends and have a great yard they can roam around in', status: 'pending')

    @application1.pets << [@lana, @doc]
  end
  describe 'visitor' do
    it 'displays application attributes' do
      visit "/applications/#{@application1.id}"

      expect(page).to have_content(@application1.name)
      expect(page).to have_content("Address:\n#{@application1.street_address}, #{@application1.city}, #{@application1.state} #{@application1.zip_code}")
      expect(page).to have_content("Why I'd be a good home for this pet(s):\n#{@application1.home_description}")
      expect(page).to have_content("Pet(s) to adopt:\n#{@lana.name}\n#{@doc.name}")
      expect(page).to have_content("Status:\n#{@application1.status}")
    end
  end
end
