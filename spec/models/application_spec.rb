require 'rails_helper'

RSpec.describe Application, type: :model do

  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  it 'checks to see if application has pets' do
    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    application_pets = ApplicationPet.create!(pet_id: pet_1.id, application_id: application.id)

    application_2 = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    expect(application.has_pets?).to eq(true)
    expect(application_2.has_pets?).to eq(false)
  end


  it 'checks the status of application' do
    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    application_pets = ApplicationPet.create!(pet_id: pet_1.id, application_id: application.id)

    application_2 = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'Pending')
    expect(application.in_progress?).to eq(true)
    expect(application_2.in_progress?).to eq(false)
  end

  it 'can update status of application, based on description' do
    shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    pet_2 = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    pet_3 = shelter_1.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    application = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    application_pets = ApplicationPet.create!(pet_id: pet_1.id, application_id: application.id)

    application_2 = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'Pending')
    application.status_update
    # binding.pry
    expect(application.status).to eq("Pending")

  end

end
