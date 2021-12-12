require 'rails_helper'
RSpec.describe 'the application index page' do

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @mr_pirate = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
  end

  it 'can create an application from a pet' do
    @application_mr_pirate = @mr_pirate.applications.create!(name: 'John', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
  end

  it 'can add pets to application that already exists - create ApplicationPets' do
    @application_joe = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    # binding.pry

    buster = @shelter_1.pets.create!(name: 'Buster', breed: 'lab', age: 8, adoptable: true)

  end

end
