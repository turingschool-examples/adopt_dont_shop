require 'rails_helper'

RSpec.describe 'Admin Shelters Show page' do
  before (:each) do
    @furry = Shelter.create!(name:'Furry Shelter', foster_program: true, city: 'New Orleans', rank: 5)
    @small = Shelter.create!(name:'Small Friends Shelter', foster_program: false, city: 'Atlanta', rank: 2)
    @paws = Shelter.create!(name: 'Dirty Paws Home', foster_program: true, city: 'Kansas City', rank: 4)

    @bruce = @furry.pets.create!(name: 'Bruce', age: 3, adoptable: true, breed: 'black lab')
    @lana = @furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')

    @rollo = @small.pets.create!(name: 'Rollo', age: 3, adoptable: true, breed: 'hamster')
    @pinky = @small.pets.create!(name: 'Pinky', age: 1, adoptable: true, breed: 'weasel')

    @addie = @paws.pets.create!(name: 'Addie', age: 2, adoptable: true, breed: 'long-haired')
    @lily = @paws.pets.create!(name: 'Lily', age: 10, adoptable: true, breed: 'Maltese')

    @application1 = Applicant.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I love my furry friends and have a great yard they can roam around in', status: 'pending')
    @application2 = Applicant.create!(name: 'Amanda', street_address: '9892 Colorado Blvd.', city: 'Fargo', state: 'ND', zip_code:74563, home_description: 'Cuddles, pets, and long walks are my favorite things.', status: 'pending')
    @application3 = Applicant.create!(name: 'Bob', street_address: '123 Builders Lane', city: 'Las Vegas', state: 'NV', zip_code: 99298, home_description: 'I just lost my dog and looking for another', status: 'in prorgess')
    @application4 = Applicant.create!(name: 'Scott', street_address: '4425 Hatters Dr.', city: 'New Orleans', state: 'LA', zip_code: 65356, home_description: 'Hiking and camping are my favorites', status: 'pending')

    @application1.pets << [@pinky]
    @application2.pets << [@lily]
    @application4.pets << [@rollo]
  end

  describe 'pending' do
    it 'can display applications with pending status' do
      visit "/admin/shelters/#{@small.id}"

      expect(page).to have_content('Pending Applications')

      within(:css, "##{@application1.id}") do
        expect(page).to have_content(@application1.name)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.state)
      end

      within(:css, "##{@application4.id}") do
        expect(page).to have_content(@application4.name)
        expect(page).to have_content(@application4.city)
        expect(page).to have_content(@application4.state)
      end
    end

    describe 'links' do
      it 'can visit application show page' do
        visit "/admin/shelters/#{@small.id}"

        within(:css, "##{@application1.id}") do
          click_on("#{@application1.name}")
        end

        expect(current_path).to eq("/admin/applications/#{@application1.id}")
      end
    end
  end
end
