require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end
  
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street_address}
    it {should validate_presence_of :city} 
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip} 
  end
  
  describe 'instance methods' do
    it 'should be able to determine in progress or not' do
      app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')

      expect(app_1.in_progress?).to be true
    end

    it 'should be able to determine if an app has pets or not' do
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')
      pet_1 = app_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

      expect(app_1.pets?).to be true
    end

    it 'can update params_status to approved' do
      shelter_1 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      app_1 = Application.create!(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i luv animals') 
      pet_1 = app_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)

      app_1.params_status('a', app_1.id)

      expect(app_1.status).to eq("Approved") # WHY DOESN"T THIS WORK?!
    end

    it 'can update params_status to rejected' do
      shelter_1 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, status: "Pending", description: 'i luv animals') 
      pet_1 = app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter_1.id)

      app_1.params_status('r', app_1.id)

      expect(app_1.status).to eq("Rejected")
    end

    describe 'it can update app status' do
      it 'should be able to update status to In Progress' do
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938)
        pet_1 = app_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
  
        expect(app_1.update_status.status).to eq('In Progress')
      end

      it 'should be able to update status to Pending' do
        shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')
        pet_1 = app_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
  
        expect(app_1.update_status.status).to eq('Pending')
      end
    end
  end
end