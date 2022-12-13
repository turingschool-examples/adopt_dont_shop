require 'rails_helper'

RSpec.describe Application, type: :model do
  
  describe 'relationship' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'instance methods' do
    it 'displays address' do
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "pending" )
      
      expect(@application.address).to eq("#{@application.street_address} "+
        "#{@application.city} "+
        "#{@application.state} "+
        "#{@application.zip_code}")
        
      expect(@application.address).to eq("123 street lane denver co 80218")
    end
    
    it 'displays associated pet names' do
      @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "pending" )
      @pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
      @pet_2 = Pet.create!(name: 'Doggy', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
      @application_pet = ApplicationPet.create!(application_id: @application.id, pet_id: @pet.id)
      @application_pet_2 = ApplicationPet.create!(application_id: @application.id, pet_id: @pet_2.id)
      
      expect(@application.pet_names.include?("Scooby")).to be true
      expect(@application.pet_names.length).to eq 2
    end
    
    it 'in_progress?' do
      @application_1 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "Pending" )
      @application_2 = Application.create!(name: 'Bob', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "In Progress" )
      
      expect(@application_1.in_progress?).to be false
      expect(@application_2.in_progress?).to be true
    end
    
    it 'has_pets?' do
      @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "pending" )
      @pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
      @application_pet = ApplicationPet.create!(application_id: @application.id, pet_id: @pet.id)
      @application_2 = Application.create!(name: 'Bob', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "In Progress" )
      
      expect(@application.has_pets?).to be true
      expect(@application_2.has_pets?).to be false
    end
    
    it 'no_description?' do
      @application_1 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", status: "Pending" )
      @application_2 = Application.create!(name: 'Bob', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", status: "In Progress" )
      
      
      expect(@application_1.no_description?).to be false
      expect(@application_2.no_description?).to be true
    end
  end
end