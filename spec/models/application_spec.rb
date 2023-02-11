require 'rails_helper'

RSpec.describe Application, type: :model do
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
end
