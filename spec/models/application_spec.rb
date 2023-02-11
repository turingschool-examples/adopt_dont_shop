require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_numericality_of :zip }
    it { should validate_presence_of :description }
  end

  describe "User Story 1" do 
    it "status is set to In Progress by default and can change" do 
      app_1 = Application.create!(name: "joe", street_address: "123 Main St", city: "Boston", state: "MA", zip: 12346, description: "This is a description", status: 0)
      expect(app_1.status).to eq("In Progress")

      app_1.status = 1
      expect(app_1.status).to eq("Pending")
    
      app_1.status = 2
      expect(app_1.status).to eq("Accepted")
       
      app_1.status = 3
      expect(app_1.status).to eq("Rejected")
    end
  end
end