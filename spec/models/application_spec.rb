require 'rails_helper'

RSpec.describe Application, type: :model do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Denver Dogs', city: 'Denver', foster_program: true, rank: 9)
    @pet12 = @shelter1.pets.create(name: 'Spike', age: 3, breed: 'doberman', adoptable: true)
    @application1 = Application.create!(name: 'Chris', street_address: '123 Main St', city: 'Hometown', state: 'CO', zipcode: "00004")
  end

  describe "relationships" do
    it {should have_many(:pet).through(:pet_applications)}
    it {should have_many(:pet_applications)}
  end

  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:street_address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zipcode)}
    it {should validate_presence_of(:status)}
  end

  it 'can change the status of a application to pending when submitted' do
    expect(@application1.status).to eq("In Progress")
    @application1.status_pending
    expect(@application1).to eq("Pending")
  end
end
