require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships'do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zipcode}
    it { should validate_presence_of :description}
    it { should validate_presence_of :status}
  end

  describe 'isntance methods' do
    it '#all_pets_approved?' do
      application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

      application.approved_pet_ids << pet_1.id
      application.approved_pet_ids << pet_2.id
      application.approved_pet_ids << pet_3.id

      expect(application.all_pets_approved?).to eq(true)
    end

    it '#all_pets_have_ruling?' do
      application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

      application.approved_pet_ids << pet_1.id
      application.approved_pet_ids << pet_2.id

      expect(application.all_pets_have_ruling?).to eq(false)

      application.rejected_pet_ids << pet_3.id

      expect(application.all_pets_have_ruling?).to eq(true)
    end
  end
end
