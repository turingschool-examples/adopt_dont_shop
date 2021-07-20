require 'rails_helper'

RSpec.describe 'admin shelters index' do
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
    @application4 = Applicant.create!(name: 'Scott', street_address: '4425 Hatters Dr.', city: 'New Orleans', state: 'LA', zip_code: 65356, home_description: 'Hiking and camping are my favorites', status: 'approved')

    @application1.pets << [@pinky]
    @application2.pets << [@lily]
    @application4.pets << [@rollo]
  end
  describe 'admin' do
    it 'can display all shelters in reverse alphabetical order' do
      visit '/admin/shelters'

      expect(page).to have_content("#{@small.name}\n#{@furry.name}\n#{@paws.name}")
    end

     it 'has a section with shelters with pending applications' do
       visit '/admin/shelters'

       expect(page).to have_content('Shelters with Pending Applications')
       within(:css, ".pending")do
        expect(page).to have_content(@small.name)
        expect(page).to have_content(@paws.name)
        expect(page).to_not have_content(@furry.name)
       end
     end
  end

  describe 'links' do
    it 'can access each shelters applications index' do
      visit '/admin/shelters'
      click_link(@furry.name)
      expect(current_path).to eq("/admin/shelters/#{@furry.id}")

      visit '/admin/shelters'
      click_link(@small.name)
      expect(current_path).to eq("/admin/shelters/#{@small.id}")

      visit '/admin/shelters'
      click_link(@paws.name)
      expect(current_path).to eq("/admin/shelters/#{@paws.id}")
    end
  end
end
