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
                                        status: "Pending")
    expect(application_1.description).to eq("I like turtles")
    end
  end
end