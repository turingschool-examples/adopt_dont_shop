require 'rails_helper'

RSpec.describe Form, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_forms) }
    it { should have_many(:pets).through(:pet_forms) }
    it {should validate_presence_of :name}
    it {should validate_presence_of :street_address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip_code}
    it {should validate_presence_of :description}
  end

  describe 'status' do
    it 'can have a status' do
      @form = Form.create!(name: "John Smith", street_address: "123 Main St.", city: "Denver", state: "CO", zip_code: 80202, description: "I want a pet.", status: 0)
     
      @form.status = 0
      expect(@form.status).to eq("In Progress")
      @form.status = 1
      expect(@form.status).to eq("Pending")
      @form.status = 2
      expect(@form.status).to eq("Accepted")
      @form.status = 3
      expect(@form.status).to eq("Rejected")
    end
  end
end