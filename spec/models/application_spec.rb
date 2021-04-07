require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many(:pet_applications)}
    it {should have_many(:pets)}
  end

  describe 'vaidations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip_code)}
  end

  describe "default" do
    it 'should return default settings for description and status'do
    @jane = Application.create(name: "Jane", address: "1234 Cherry St.", city: "Franklin", state:"Pennsylvania", zip_code: 18801, status: "Pending", description: "cat")
    expect(@jane.description) == "_"
    expect(@jane.status) == "In Progress"
    expect(@jane.status) != "Pending"
    expect(@jane.description) != "cat"
    end
  end
end
