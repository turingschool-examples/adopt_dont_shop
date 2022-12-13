require 'rails_helper'

RSpec.describe Application do
  it {should have_many(:pets).through(:application_pets)}
  it {should have_many :application_pets}
  it {should validate_presence_of :name}
  it {should validate_presence_of :street_address}
  it {should validate_presence_of :city}
  it {should validate_presence_of :state}
  it {should validate_presence_of :zipcode}

  describe 'Change status' do
    it 'changes the status to pending' do
      application = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301")
     
      application.change_status

      expect(application.status).to eq('Pending')
    end
  end

  describe 'any_pets?' do 
    it 'will check if number of pets is greater than zero' do
      shelter1 = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter1.pets.create!(name: "Cozmo", age: 8, breed: 'Aussie', adoptable: true)
      application = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")

      expect(application.any_pets?).to be true

      application_2 = Application.create!(name: 'Carla', street_address: "1234 91st Ave", city: "Salem", state: "OR", zipcode: "75849")
      
      expect(application_2.any_pets?).to be false
    end
  end
end