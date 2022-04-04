require 'rails_helper'

RSpec.describe PetApplication do
  # describe 'validations' do
  #   it { should validate_presence_of(:status) }
  # end

  describe 'relationships' do
    it { should belong_to :pet}
    it { should belong_to :application}
  end

  it 'sets default setting for status' do
    pet = Pet.new(name: "Lucy", age: 2, breed: "beagle", adoptable: true)
    application_1 = Application.create!(name: 'Anita Barker', street_address: '2468 Park Blvd.', city: 'Denver', state: 'CO', zipcode: '80202')
    pet_app = PetApplication.create!(pet: pet, application: application_1)

    expect(pet_app.status).to eq("Pending")
  end
end
