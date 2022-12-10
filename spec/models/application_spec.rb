require 'rails_helper'

RSpec.describe Application do
  it {should have_many(:pets).through(:application_pets)}
  it { should have_many :application_pets}
  describe 'Change status' do
    it 'changes the status to pending' do
      application = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301")
     
      application.change_status

      expect(application.status).to eq('Pending')
    end

    describe 'pending_applications' do
      it 'shows all applications for a shelter with pending status' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      pet_3 = shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      application_1 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
      application_2 = pet_1.applications.create!(name: 'Jimbo', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Jimbo wants a buddy", status: "Pending")
      application_3 = pet_3.applications.create!(name: 'Bill', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Bill wants a buddy", status: "In Progress")

      expect(Application.pending_applications).to eq([application_1, application_2])
      end
    end
  end
end