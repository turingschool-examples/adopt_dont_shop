require 'rails_helper'

RSpec.describe 'the admin shelters index page' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Humane Society', city: 'Humboldt CA', foster_program: true, rank: 4)
    @app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, status: "Pending", description: "something")
    @app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, status: "Pending", description: "something")
    @pet_1 = @shelter_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Fran', age: 4, breed: 'French Bulldog', adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: 'Gilbert', age: 4, breed: 'Mutt', adoptable: true)
    @pet_app_1 = ApplicationPet.create!(application: @app_1, pet: @pet_1)
    @pet_app_2 = ApplicationPet.create!(application: @app_2, pet: @pet_2)
    @pet_app_3 = ApplicationPet.create!(application: @app_2, pet: @pet_3)
  end

  it 'has an admin shelters index page' do
    visit "/admin/shelters"

    expect(current_path).to eq("/admin/shelters")
    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
  end

  it 'lists shelters in descending alphabetical order' do
    visit "/admin/shelters"

    within("#sheltersAlphabetically p:nth-child(1)") do
      expect(page).to have_content(@shelter_1.name)
    end
    within("#sheltersAlphabetically p:nth-child(2)") do
      expect(page).to have_content(@shelter_2.name)
    end
  end
end
