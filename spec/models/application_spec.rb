require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:description)}
  end

  describe "Instance methods" do
    # describe '#incomplete_form?' do
    #   it 'checks for incomplete form fields' do
    #     application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")

    #     expect(application.incomplete_form?).to be true
    #   end
    # end
    # describe '#list_incomplete_fields' do
    #   it "returns and array of incomplete fields" do
    #     application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", zipcode: 80001, description: 'temp description', status: "In Progress")

    #     expect(application.list_incomplete_fields).to eq(["city", "state"])
    #   end
    # end

    describe '#has_pets_added?' do
      it "returns true if the application has added pets" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")
        shelter = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = shelter.pets.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky")

        ApplicationPet.create!(pet: becky, application: application)

        expect(application.has_pets_added?).to eq(true)
      end
    end
  end
end
