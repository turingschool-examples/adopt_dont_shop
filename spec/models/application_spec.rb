require 'rails_helper'

RSpec.describe Application, type: :model do

  before do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @lobster = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @skeeter = Pet.create!(adoptable: true, age: 7, breed: 'corgie', name: 'Skeeter', shelter_id: @shelter.id)
    @skippy = Pet.create!(adoptable: true, age: 5, breed: 'lab', name: 'skippy', shelter_id: @shelter.id)
    @bonds = Application.create!(name: 'Barry Bonds', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@skeeter.id}, #{@lobster.id}", status: 1)
    @app_pet1 = ApplicationPet.create!(application: @bonds, pet: @skeeter, pet_status: 0)
    @app_pet2 = ApplicationPet.create!(application: @bonds, pet: @lobster, pet_status: 1)
    @app_pet3 = ApplicationPet.create!(application: @bonds, pet: @skippy, pet_status: 2)

    @shelter2 = Shelter.create!(name: 'denver shelter', city: 'Aurora, CO', foster_program: false, rank: 8)
    @lugnut = Pet.create!(adoptable: true, age: 3, breed: 'corgi', name: 'LugNut', shelter_id: @shelter2.id)
    @ruby = Pet.create!(adoptable: true, age: 7, breed: 'mut', name: 'Ruby', shelter_id: @shelter2.id)
    @taki = Pet.create!(adoptable: true, age: 5, breed: 'chaweenie', name: 'Taki', shelter_id: @shelter2.id)
    @sosa = Application.create!(name: 'Sammy Sosa', address: '16340 some street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@lugnut.id}, #{@ruby.id}, #{@taki.id}", status: 1)
    @app_pet3 = ApplicationPet.create!(application: @sosa, pet: @lugnut, pet_status: 1)
    @app_pet4 = ApplicationPet.create!(application: @sosa, pet: @ruby, pet_status: 1)
    @app_pet5 = ApplicationPet.create!(application: @sosa, pet: @taki, pet_status: 1)

    @mark = Application.create!(name: 'Mark McGuire', address: '16340 drive street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@lugnut.id}, #{@ruby.id}, #{@taki.id}", status: 1)
    @dog = Pet.create!(adoptable: true, age: 3, breed: 'corgi', name: 'Dog', shelter_id: @shelter2.id)
    @cat  = Pet.create!(adoptable: true, age: 7, breed: 'mut', name: 'Cat McCatFace', shelter_id: @shelter2.id)
    @app_pet6 = ApplicationPet.create!(application: @mark, pet: @dog, pet_status: 1)
    @app_pet7 = ApplicationPet.create!(application: @mark, pet: @cat, pet_status: 2)
    @ruth = Application.create!(name: 'Babe Ruth', address: '999 Yankees Stink St, Aurora, CO, 80014', description: 'stinks', pet_names: "", status: 0)


  end
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

      expect(@bonds.application_pet_status(@skeeter.id)).to eq("undecided")
      expect(@bonds.application_pet_status(@lobster.id)).to eq("approved")
      expect(@bonds.application_pet_status(@skippy.id)).to eq("denied")
    end

    describe '.all_pets_approved?' do
      it 'returns true if all pets on a single app have been approved' do
        expect(@sosa.all_pets_approved?).to eq(true)
      end

      it 'returns false if any pet on an application is denied' do
        expect(@mark.all_pets_approved?).to eq(false)
      end

      it 'returns shelters with pending apps' do
        expect(Application.pending_apps).to eq([@bonds, @sosa, @mark])
      end



    end



  end
end
