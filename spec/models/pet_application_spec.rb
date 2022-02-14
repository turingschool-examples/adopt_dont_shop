require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe 'it adds pets to an application' do
    it 'gives each pet on an application' do
      shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pirate = shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      claw = shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      joey = shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)

      app = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
        status: "In Progress"
      )

      PetApplication.create!(pet_id: pirate.id, application_id: app.id)
      PetApplication.create!(pet_id: claw.id, application_id: app.id)

      expect(app.pets).to eq([pirate, claw])
    end

    it 'gives each application that a pet is on' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pirate = shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      claw = shelter.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      joey = shelter.pets.create!(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)

      app_1 = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
        status: "In Progress"
      )

      app_2 = Application.create!(
        name: "Jerry Blank",
        street_address: "246 DumDum Ave.",
        city: "Melbourne",
        state: "IL",
        zip_code: 53262,
        description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
        status: "In Progress"
      )

      PetApplication.create!(pet_id: pirate.id, application_id: app_1.id)
      PetApplication.create!(pet_id: claw.id, application_id: app_1.id)
      PetApplication.create!(pet_id: pirate.id, application_id: app_2.id)
      PetApplication.create!(pet_id: joey.id, application_id: app_2.id)

      expect(pirate.applications).to eq([app_1, app_2])
      expect(claw.applications).to eq([app_1])
      expect(joey.applications).to eq([app_2])

      expect(app_1.pets).to eq([pirate, claw])
      expect(app_2.pets).to eq([pirate, joey])
    end
  end
end
