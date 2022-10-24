require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end
  describe "class methods" do
    describe "find_application_pet" do
      it "can find the relationship between an application and a pet in application_pets" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
        shelter_1 = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
        becky = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky", shelter: shelter_1)
        application_pet = ApplicationPet.create!(pet: becky, application: application)

        expect(ApplicationPet.find_application_pet(becky.id, application.id)).to eq(application_pet)
      end
    end
  end
end
