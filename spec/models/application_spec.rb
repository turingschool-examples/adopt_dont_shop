require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:status) }
  end

  describe "relationships" do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets)}
  end

  describe "default params" do
    it "creates an application with default description" do
    application_1 = Application.create!(name: "Chris",
                                        street_address: "19072",
                                        city: "Exeter",
                                        state: "CA",
                                        zip: 93221,
                                      )
    expect(application_1.description).to eq("I like turtles")
    expect(application_1.status).to eq("In Progress")
    end
  end

  describe "instance methods" do
    it "add_pet" do
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      application_1 = Application.create!(name: "Chris",
                                          street_address: "19072",
                                          city: "Exeter",
                                          state: "CA",
                                          zip: 93221,
                                          status: "Pending")
      application_1.add_pet(pet_1)
      expect(application_1.pets).to eq([pet_1])
    end
  end

end