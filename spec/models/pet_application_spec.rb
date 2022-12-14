require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  describe 'has status attributes' do
    it 'can change the status' do
      shelter     = create(:shelter)
      application = Application.create!(name: "Anthony", street_address: "place", city: "Tino", state: "CO", zip_code: "24325", description: "hellp", status: "pending")
      pet         = application.pets.create!(adoptable: true, age: 99, breed: "terrier", name: "booboo", shelter: shelter)
      application.pets << pet
      pet_app = PetApplication.find_by(pet_id: pet.id)
      expect(pet_app.status).to eq("pending")

      pet_app.accepted!

      expect(pet_app.status).to eq("accepted")
    end
  end
end