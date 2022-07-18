require 'rails_helper'

RSpec.describe App, type: :model do
  describe 'relationships' do
    it {should have_many :pets}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'instance methods' do
    it 'can return boolean if any app pets have been rejected' do
      app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      PetApp.create!(pet: pet_1, app: app_1, approval: 'Approved')
      PetApp.create!(pet: pet_2, app: app_1, approval: 'Rejected')

      expect(app_1.any_rejected?).to be(true)
    end

    it 'can return boolean if all app pets approved' do
      app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      PetApp.create!(pet: pet_1, app: app_1, approval: 'Approved')
      PetApp.create!(pet: pet_2, app: app_1, approval: 'Approved')

      expect(app_1.all_approved?).to be(true)
    end

    it 'can make all pets on app unadoptable' do
      app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      PetApp.create!(pet: pet_1, app: app_1)
      PetApp.create!(pet: pet_2, app: app_1)

      expect(pet_1.adoptable).to be(true)
      expect(pet_2.adoptable).to be(true)

      app_1.make_pets_unadoptable

      expect(pet_1.reload.adoptable).to be(false)
      expect(pet_2.reload.adoptable).to be(false)
    end

    it 'can make a final state update: rejected' do
      app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      PetApp.create!(pet: pet_1, app: app_1, approval: 'Approved')
      PetApp.create!(pet: pet_2, app: app_1, approval: 'Rejected')

      app_1.final_status

      expect(app_1.status).to eq('rejected')
    end

    it 'can make a final state update: accepted' do
      app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "pending")
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

      PetApp.create!(pet: pet_1, app: app_1, approval: 'Approved')
      PetApp.create!(pet: pet_2, app: app_1, approval: 'Approved')

      app_1.final_status

      expect(app_1.status).to eq('accepted')
    end
  end
end