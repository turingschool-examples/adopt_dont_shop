require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:state) }
    it { should validate_numericality_of(:zip_code) }
    it { should allow_value("In Progress").for(:status) }
    it { should allow_value("Pending").for(:status) }
    it { should allow_value("Accepted").for(:status) }
    it { should allow_value("Rejected").for(:status) }
    it { should_not allow_value("Something").for(:status) }
  end

  describe 'instance methods' do
    it 'has pets' do
      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")

      expect(application.has_pets?).to eq(false)

      application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!", status: "In Progress")
      shelter = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
      spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: shelter.id, application_id: application.id)
      frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: shelter.id, application_id: application.id)

      expect(application.has_pets?).to eq(true)
    end
  end
end
