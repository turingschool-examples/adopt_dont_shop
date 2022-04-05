require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    # it { should validate_presence_of :description }
    # it { should validate_presence_of :pet_names }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'methods' do

    it 'it returns the ApplicationPet pet_status when given a pet id' do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @lobster = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
      @skeeter = Pet.create!(adoptable: true, age: 7, breed: 'corgie', name: 'Skeeter', shelter_id: @shelter.id)
      @skippy = Pet.create!(adoptable: true, age: 5, breed: 'lab', name: 'skippy', shelter_id: @shelter.id)
      @bonds = Application.create!(name: 'Barry Bonds', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@skeeter.id}, #{@lobster.id}", status: 1)
      @sosa = Application.create!(name: 'Sammy Sosa', address: '1321 hill lane, Loveland, CO, 80054', description: 'dogs like me', pet_names: "#{@skippy.id}, #{@lobster.id}", status: 0)
      @app_pet1 = ApplicationPet.create!(application: @bonds, pet: @skeeter, pet_status: 0)
      @app_pet2 = ApplicationPet.create!(application: @bonds, pet: @lobster, pet_status: 1)
      @app_pet3 = ApplicationPet.create!(application: @bonds, pet: @skippy, pet_status: 2)

      expect(@bonds.application_pet_status(@skeeter.id)).to eq("undecided")
      expect(@bonds.application_pet_status(@lobster.id)).to eq("approved")
      expect(@bonds.application_pet_status(@skippy.id)).to eq("denied")
    end
  end
end
