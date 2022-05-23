require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:application_status) }
  end

  describe '#show_pets' do
    it "won't show pets that are added to application in search" do
      application = Application.create!(name: 'Andrew', street: "123 Street", city: "Kenosha",
        state: "WI", zip: 53144, application_status: "In Progress")
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'aBare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'bBabe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'cElle', shelter_id: shelter.id)
      PetApplication.create!(application_id: application.id, pet_id: pet_1.id)
      expect(application.show_pets).to eq([pet_2, pet_3])
    end
  end

end
