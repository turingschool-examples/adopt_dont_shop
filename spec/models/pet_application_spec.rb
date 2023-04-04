require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe '::update_to' do
    before(:each) do
      @shelter_1 = Shelter.create!(name: 'SF shelter', city: 'Santa Fe, NM', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'Burora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      @pet_5 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'ZZZ', shelter_id: @shelter_1.id)
      @pet_7 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Rufus', shelter_id: @shelter_2.id)

      @app_1 = Application.create!(name: 'JoJo', address: '23 Tanby', city: 'Denver', state: 'CO', zip: '90345', description: 'I have dog food and a roof', status: "In Progress")
      @app_2 = Application.create!(name: 'Franklin', address: '611 Wallow Ct', city: 'Santa Fe', state: 'NM', zip: '87508', description: 'Lonely guy with hella money', status: "In Progress")

      @pet_app_1 = PetApplication.create!(application: @app_1, pet: @pet_5)
      @pet_app_2 = PetApplication.create!(application: @app_2, pet: @pet_7)
    end
    
    it 'updates pet application status' do
  
      expect(@pet_app_1.status).to eq("Pending")

      @pet_app_1.update_to('Approved')

      expect(@pet_app_1.status).to eq('Approved')
    end
  end
end