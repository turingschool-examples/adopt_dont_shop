# spec/models/application_pet_spec.rb
require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end

  it "finds pets by their id" do
    shelter_1 = Shelter.create!(name: 'Big Dogs Huge Paws', city: 'Fort Collins', foster_program: false, rank: 11)
    pet_1 = shelter_1.pets.create!(name: 'Cassio', age: 2, breed: 'Akbash', adoptable: true)
    app_1 = Application.create!(
      name: "Sarah Carter",
      address: "1108 Ichabod St",
      city: "North Pole",
      state: "Alaska",
      zip: "99705")
    app_pet = ApplicationPet.create!(application: app_1, pet: pet_1, status: 'Approved')

    expect(ApplicationPet.find_by_ids(pet_1.id, app_1.id)).to eq(app_pet)
  end
end


#   def self.find_by_ids(pet_id, app_id)
#   where(pet_id: pet_id, application_id: app_id).first
#
#
#   RSpec.describe PetApp do
#   it { should belong_to(:pet) }
#   it { should belong_to(:application) }
#
#   it 'finds pet apps by ids' do
#   shelter = create(:shelter, name: 'Dogtown and Z-Boys')
#   app = create(:application, status: 'Pending')
#   pet = create(:pet, shelter: shelter)
#   pet_app = PetApp.create!(application: app, pet: pet, status: 'Approved')
#
#   expect(PetApp.pet_app_by_ids(pet.id, app.id)).to eq(pet_app)
#   end
# end
