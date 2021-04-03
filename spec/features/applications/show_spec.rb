require 'rails_helper'

RSpec.describe 'the application show' do
  before :each do

    name = ["Terry's Terriers", 'Lost and Found', 'Too Many Tails', 'Dogs Unleashed', 'Woof and Purr']
    @shelter_1 = Shelter.create!(
      foster_program: Faker::Boolean.boolean,
      name: name.pop,
      city: Faker::Address.city,
      rank: Faker::Number.between(from: 0, to: 5)
    )
    @pet_1 = @shelter_1.pets.create!(
      adoptable: Faker::Boolean.boolean,
      age: Faker::Number.between(from: 0, to: 25),
      breed: Faker::Creature::Dog.breed,
      name: Faker::Creature::Dog.name
    )
    @pet_2 = @shelter_1.pets.create!(
      adoptable: Faker::Boolean.boolean,
      age: Faker::Number.between(from: 0, to: 25),
      breed: Faker::Creature::Dog.breed,
      name: Faker::Creature::Dog.name
    )
    status = ["In Progress", "Pending", "Accepted", "Rejected"]
    @application_1 = Application.create!(
      name: Faker::Name.unique.name,
      street_address: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip_code: Faker::Address.zip_code,
      description: Faker::Company.bs,
      status: status.sample
    )
    @pet_1.applications << @application_1
  end

  it "shows an application and all of it's attribues" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
  end
end
