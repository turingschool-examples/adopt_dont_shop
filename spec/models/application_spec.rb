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

      application.application_pets.each {|application_pet| application_pet.update(status: :approved)}

      expect(application.all_pets_approved?).to eq(true)
    end

    it '#all_pets_have_ruling?' do
      application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

      application.application_pets.third.update(status: :approved)
      application.application_pets.second.update(status: :approved)
      application.application_pets.first.update(status: :approved)

      expect(application.all_pets_have_ruling?).to eq(true)
    end

    it '#any_pets_rejected?' do
      application = Application.create!(name: 'Chris', address: '505 Main St.', city: 'Denver', state: 'CO', zipcode: '80205', description: "I'm great with dogs.", status: 'In-progress')
      shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      pet_1 = application.pets.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_2 = application.pets.create!(name: 'Sparky', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      pet_3 = application.pets.create!(name: 'Spot', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

      application.application_pets.third.update(status: :approved)
      application.application_pets.second.update(status: :approved)
      application.application_pets.first.update(status: :rejected)

      expect(application.any_pets_rejected?).to eq(true)
    end
  end
end
