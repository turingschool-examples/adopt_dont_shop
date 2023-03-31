require 'rails_helper'

RSpec.describe Application, type: :model do
  let!(:application) { Application.create!(name: "John Doe", 
                                           street_address: "123 Main St", 
                                           city: "Denver", 
                                           state: "CO", 
                                           zip_code: "80202", 
                                           description: "I love dogs", 
                                           status: "In Progress") }

  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(application).to be_a(Application)
      expect(application.name).to eq("John Doe")
      expect(application.street_address).to eq("123 Main St")
      expect(application.status).to eq("In Progress")
    end
  end

  describe 'instance methods' do

  end
end