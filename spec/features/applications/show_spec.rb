require 'rails_helper'

RSpec.describe 'show page' do
  before do
    @shelter = Shelter.create!(
      name: Faker::App.name,
      foster_program: Faker::Boolean::boolean(true_ratio: 0.5),
      city: Faker::Address.city,
      rank: rand(1..100)
    )
    @app = Application.create!(
            name: Faker::FunnyName.two_word_name,
            street_address: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state,
            zip_code: Faker::Address.zip_code,
            description: Faker::Lorem.sentence
          )

    @app.pets.create!(
      name: Faker::FunnyName.name,
      adoptable: Faker::Boolean::boolean(true_ratio: 0.66),
      age: rand(1..1000),
      breed: Faker::Creature::Cat.breed,
      shelter_id: @shelter.id
    )
    @app.pets.create!(
      name: Faker::FunnyName.name,
      adoptable: Faker::Boolean::boolean(true_ratio: 0.66),
      age: rand(1..1000),
      breed: Faker::Creature::Cat.breed,
      shelter_id: @shelter.id
    )
    @app_2 = Application.create!(
            name: "Woohoo",
            street_address: "address",
            city: "Faker::Address.city",
            state: "Faker::Address.state",
            zip_code: "Faker::Address.zip_code",
            description: "Faker::Lorem.sentence"
          )
    @app_2.pets.create!(
      name: "Sneaky Winky",
      adoptable: Faker::Boolean::boolean(true_ratio: 0.66),
      age: rand(1..1000),
      breed: Faker::Creature::Cat.breed,
      shelter_id: @shelter.id
    )
    @app_2.pets.create!(
      name: "Billy the Boi",
      adoptable: Faker::Boolean::boolean(true_ratio: 0.66),
      age: rand(1..1000),
      breed: Faker::Creature::Cat.breed,
      shelter_id: @shelter.id
    )
  end

  it 'shows the applicant attributes' do
    visit "/applications/#{@app.id}"

    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.street_address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zip_code)
    expect(page).to have_content(@app.description)
    expect(page).to have_content(@app.status)

    expect(page).to_not have_content(@app_2.name)
    expect(page).to_not have_content(@app_2.street_address)
    expect(page).to_not have_content(@app_2.city)
    expect(page).to_not have_content(@app_2.state)
    expect(page).to_not have_content(@app_2.zip_code)
    expect(page).to_not have_content(@app_2.description)
  end

  it 'shows the apps pets' do
    visit "/applications/#{@app.id}"

    @app.pets.each do |pet|
      expect(page).to have_content(pet.name)
    end

    @app_2.pets.each do |pet|
      expect(page).to_not have_content(pet.name)
    end
  end

  it 'has a search bar if the application status is in progress' do
    @app.status = "in progress"

    visit "/applications/#{@app.id}"

    @pet = Pet.create!(adoptable: true, age: 28, breed: "human", name: "Henry", shelter: @shelter)

    # fill_in "Search", with @pet.name
    fill_in('search', with: @pet.name)
    click_button "Search"

    expect(page).to have_content(@pet.name)
  end
end