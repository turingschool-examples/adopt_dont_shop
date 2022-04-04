require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
  end

  it "can find pet by name" do
    smith_app = Application.create!(name: "Bobby Smith", address: "3245 E 1st", city: "Lakewood", state: "CO", zipcode: "80026", description: "Im Awesome!", app_status: "Rejected")
    shelter = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
    scooby = Pet.create!(adoptable: true, age: 1, breed: "sphynx", name: "Scooby", shelter_id: shelter.id)
    expect(smith_app.find_pet_by_name("Scooby")).to eq(scooby)
  end
end
