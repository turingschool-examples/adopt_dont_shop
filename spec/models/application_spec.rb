require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
  
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)

    @application_1 = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, app_status: "Pending", pets_on_app: @pet_1.name)
    
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application_1.id)
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'status' do
    it 'can have a status' do
      @application = Application.create!(name: "Andra", street_address: "2305 W. Lake St.", city: "Fort Collins", state: "Colorado", zip_code: 80525, description: "I love them", pets_on_app: "Daisy, Sal", app_status: "Accepted" )
      
      @application.app_status = 0
      expect(@application.app_status).to eq("In Progress")
      @application.app_status = 1
      expect(@application.app_status).to eq("Pending")
      @application.app_status = 2
      expect(@application.app_status).to eq("Accepted")
      @application.app_status = 3
      expect(@application.app_status).to eq("Rejected")
    end
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
  end
end
